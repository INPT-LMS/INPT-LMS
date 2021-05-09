package inpt.lms.gateway;

import static com.github.tomakehurst.wiremock.client.WireMock.aResponse;
import static com.github.tomakehurst.wiremock.client.WireMock.get;
import static com.github.tomakehurst.wiremock.client.WireMock.stubFor;
import static com.github.tomakehurst.wiremock.client.WireMock.urlEqualTo;
import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.cloud.contract.wiremock.AutoConfigureWireMock;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.reactive.server.WebTestClient;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
properties = {"inpt.lms.url.service.gestioncompte=http://localhost:"
		+ "${wiremock.server.port}",
"inpt.lms.secret=UXPKG3SE4wxpn8JgV9pt5Nz6hylc8aYyqLP6GjWnSM8="})
@AutoConfigureWireMock(port = 0)
class GatewayTests {

	@Autowired
	private WebTestClient webClient;

	@Test
	void testShouldBeOk(){
		stubFor(get(urlEqualTo("/update"))
				.willReturn(aResponse().withStatus(200).withBody("OK")));

		webClient
		.get().uri("/account/update").header("Authorization", "Bearer eyJhbGciOiJIUz"
				+ "I1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG"
				+ "4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJ1c2VySWQiOjE1fQ.A4Cb8bbicInDRhzL"
				+ "5mlkTdY42M1eJvcJogHVJX8EQfo")
		.exchange()
		.expectStatus().isOk()
		.expectBody()
		.consumeWith(response -> assertThat(response.getResponseBody())
				.isEqualTo("OK".getBytes()));
	}

	@Test
	void testShouldBeOkWithoutToken() {
		stubFor(get(urlEqualTo("/register"))
				.willReturn(aResponse().withStatus(200).withBody("OK")));

		webClient
		.get().uri("/account/register")
		.exchange()
		.expectStatus().isOk()
		.expectBody()
		.consumeWith(response -> assertThat(response.getResponseBody())
				.isEqualTo("OK".getBytes()));
	}

	@Test
	void testShouldBeUnauthorizedBadToken(){
		webClient
		.get().uri("/account/update").header("Authorization", "Bearer badToken")
		.exchange()
		.expectStatus().isUnauthorized();
	}

	@Test
	void testShouldBeUnauthorizedNoToken(){
		webClient
		.get().uri("/account/update")
		.exchange()
		.expectStatus().isUnauthorized();
	}
}