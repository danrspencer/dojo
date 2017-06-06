import org.fest.assertions.api.Assertions.*
import org.testng.annotations.Test

@Test fun `it should return true`() {
    assertThat(foo()).isTrue
}