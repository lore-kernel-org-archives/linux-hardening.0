Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9D20330;
	Thu,  5 Jun 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159431; cv=none; b=XuLQNML0q+15mxiABwpRZf9ywIgQARJ/ElzlbcBF2+O/Ffz5UPBGkZzpztqTskCg71WfWaNdpuVM8n9VDnkSvaU8ii45jCTQSQ7903kdKAaapU88WyRjXndRcXkjhvT9BJVSw/GMHk60gonbpqF3YR8EJc1rOJj9oc1ZQvsrO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159431; c=relaxed/simple;
	bh=KomAMxAvk/8Fc5tTwcHMRIr9zWc5gjWQmOub4ROYpow=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjqPxkIekkPfYfsAjZibl3/x9OvIWVSx3QvA/mbrMbNoqtcx4z24uyEQBqKQVzIKomr1DAUkbVokrQxXik3lFYKUCj5VjwtRzKCAw9tiwEPp4qDUo2FIcoXDdxjqjzqLrrkflp+07Y0Mxv00cnYZaZ5+yj2gjlJl79Gt/L3qiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=d9QT9hUK; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="d9QT9hUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1749159426; x=1749418626;
	bh=21FryjTDqEqpqP5odesMO7gwe0g3ollvbPo6Ejjt5TE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=d9QT9hUK1TUc6sevjceVQVHiZqxlt/OlbaghCqW6E3ztPOLroSqNmbXMvATygHrNs
	 4iGibH2JJA3xdd+5lew1DpwVMuWYuf6iaQWRWN3t/q3MQpB8y4uzUdNGFnNQYNvgqi
	 ghgXLjLEDP8/xibfWMvyY1xaK9ut0auTFkGzPoYlbsCzY9xxY1T5jRx2q7UBkjRLfb
	 X8sb1GiHUJ9JL3Feiy4eu2KXmR7969lSLP899p/hp/fXCEZiKwmeHwDKSb/kIq0Omm
	 ygED7M35lcZTfAs5SdDxNfXWbnll4sVtnbGLoxrUt0VBXijubscewOW47H8/H0Kavy
	 UCLmo5zLR4/QA==
Date: Thu, 05 Jun 2025 21:37:00 +0000
To: Burak Emir <bqe@google.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v11 4/5] rust: add find_bit_benchmark_rust module.
Message-ID: <pXt1ZkjyScL3fnnuyw12MHGyxxDunKpUjhGl_tL4kg8FpobamrUohmzQyqMxtCPfgbUmmPl4ZE6wco8Yqs6aLD5jLTD5ZL-zeNo8wk0uKUM=@protonmail.com>
In-Reply-To: <20250602135231.1615281-5-bqe@google.com>
References: <20250602135231.1615281-1-bqe@google.com> <20250602135231.1615281-5-bqe@google.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: f90f569db84e596600f06996b3f91aa40038543e
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 2nd, 2025 at 16.53, Burak Emir <bqe@google.com> wrote:
> Microbenchmark protected by a config FIND_BIT_BENCHMARK_RUST,
> following `find_bit_benchmark.c` but testing the Rust Bitmap API.
>=20
> We add a fill_random() method protected by the config in order to
> maintain the abstraction.
>=20
> The sample output from the benchmark, both C and Rust version:
>=20
> find_bit_benchmark.c output:
> ```
> Start testing find_bit() with random-filled bitmap
> [  438.101937] find_next_bit:                  860188 ns, 163419 iteratio=
ns
> [  438.109471] find_next_zero_bit:             912342 ns, 164262 iteratio=
ns
> [  438.116820] find_last_bit:                  726003 ns, 163419 iteratio=
ns
> [  438.130509] find_nth_bit:                  7056993 ns,  16269 iteratio=
ns
> [  438.139099] find_first_bit:                1963272 ns,  16270 iteratio=
ns
> [  438.173043] find_first_and_bit:           27314224 ns,  32654 iteratio=
ns
> [  438.180065] find_next_and_bit:              398752 ns,  73705 iteratio=
ns
> [  438.186689]
>                Start testing find_bit() with sparse bitmap
> [  438.193375] find_next_bit:                    9675 ns,    656 iteratio=
ns
> [  438.201765] find_next_zero_bit:            1766136 ns, 327025 iteratio=
ns
> [  438.208429] find_last_bit:                    9017 ns,    656 iteratio=
ns
> [  438.217816] find_nth_bit:                  2749742 ns,    655 iteratio=
ns
> [  438.225168] find_first_bit:                 721799 ns,    656 iteratio=
ns
> [  438.231797] find_first_and_bit:               2819 ns,      1 iteratio=
ns
> [  438.238441] find_next_and_bit:                3159 ns,      1 iteratio=
ns
> ```
>=20
> find_bit_benchmark_rust.rs output:
> ```
> [  451.182459] find_bit_benchmark_rust_module:
> [  451.186688] Start testing find_bit() Rust with random-filled bitmap
> [  451.194450] next_bit:                       777950 ns, 163644 iteratio=
ns
> [  451.201997] next_zero_bit:                  918889 ns, 164036 iteratio=
ns
> [  451.208642] Start testing find_bit() Rust with sparse bitmap
> [  451.214300] next_bit:                         9181 ns,    654 iteratio=
ns
> [  451.222806] next_zero_bit:                 1855504 ns, 327026 iteratio=
ns
> ```
>=20
> Here are the results from 32 samples, with 95% confidence interval.
> The microbenchmark was built with RUST_BITMAP_HARDENED=3Dn and run on a
> machine that did not execute other processes.
>=20
> Random-filled bitmap:
> +-----------+-------+-----------+--------------+-----------+-----------+
> | Benchmark | Lang  | Mean (ms) | Std Dev (ms) | 95% CI Lo | 95% CI Hi |
> +-----------+-------+-----------+--------------+-----------+-----------+
> | find_bit/ | C     |    825.07 |        53.89 |    806.40 |    843.74 |
> | next_bit  | Rust  |    870.91 |        46.29 |    854.88 |    886.95 |
> +-----------+-------+-----------+--------------+-----------+-----------+
> | find_zero/| C     |    933.56 |        56.34 |    914.04 |    953.08 |
> | next_zero | Rust  |    945.85 |        60.44 |    924.91 |    966.79 |
> +-----------+-------+-----------+--------------+-----------+-----------+
>=20
> Rust appears 5.5% slower for next_bit, 1.3% slower for next_zero.
>=20
> Sparse bitmap:
> +-----------+-------+-----------+--------------+-----------+-----------+
> | Benchmark | Lang  | Mean (ms) | Std Dev (ms) | 95% CI Lo | 95% CI Hi |
> +-----------+-------+-----------+--------------+-----------+-----------+
> | find_bit/ | C     |     13.17 |         6.21 |     11.01 |     15.32 |
> | next_bit  | Rust  |     14.30 |         8.27 |     11.43 |     17.17 |
> +-----------+-------+-----------+--------------+-----------+-----------+
> | find_zero/| C     |   1859.31 |        82.30 |   1830.80 |   1887.83 |
> | next_zero | Rust  |   1908.09 |       139.82 |   1859.65 |   1956.54 |
> +-----------+-------+-----------+--------------+-----------+-----------+
>=20
> Rust appears 8.5% slower for next_bit, 2.6% slower for next_zero.
>=20
> In summary, taking the arithmetic mean of all slow-downs, we can say
> the Rust API has a 4.5% slowdown.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS                     |  1 +
>  lib/Kconfig.debug               | 13 +++++
>  lib/Makefile                    |  1 +
>  lib/find_bit_benchmark_rust.rs  | 95 +++++++++++++++++++++++++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/bitmap.rs           | 14 +++++
>  6 files changed, 125 insertions(+)
>  create mode 100644 lib/find_bit_benchmark_rust.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 565eaa015d9e..943d85ed1876 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4132,6 +4132,7 @@ M:=09Alice Ryhl <aliceryhl@google.com>
>  M:=09Burak Emir <bqe@google.com>
>  R:=09Yury Norov <yury.norov@gmail.com>
>  S:=09Maintained
> +F:=09lib/find_bit_benchmark_rust.rs
>  F:=09rust/kernel/bitmap.rs
>=20
>  BITOPS API
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f9051ab610d5..3f826a73bdbf 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2605,6 +2605,19 @@ config FIND_BIT_BENCHMARK
>=20
>  =09  If unsure, say N.
>=20
> +config FIND_BIT_BENCHMARK_RUST
> +=09tristate "Test find_bit functions in Rust"
> +=09depends on CONFIG_RUST

The `CONFIG_` prefix should be removed.

> +=09help
> +=09  This builds the "find_bit_benchmark_rust" module. It is a micro
> +          benchmark that measures the performance of Rust functions that
> +          correspond to the find_*_bit() operations in C. It follows the
> +          FIND_BIT_BENCHMARK closely but will in general not yield same
> +          numbers due to extra bounds checks and overhead of foreign
> +          function calls.
> +
> +=09  If unsure, say N.
> +
>  config TEST_FIRMWARE
>  =09tristate "Test firmware loading via userspace interface"
>  =09depends on FW_LOADER

[...]

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 28c11e400d1e..9fefb2473099 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -252,6 +252,20 @@ pub fn new(nbits: usize, flags: Flags) -> Result<Sel=
f, AllocError> {
>      pub fn len(&self) -> usize {
>          self.nbits
>      }
> +
> +    /// Fills this `Bitmap` with random bits.
> +    #[cfg(CONFIG_FIND_BIT_BENCHMARK_RUST)]
> +    pub fn fill_random(&mut self) {
> +        // SAFETY: `self.as_mut_ptr` points to either an array of the
> +        // appropriate length or one usize.
> +        unsafe {
> +            bindings::get_random_bytes(
> +                self.as_mut_ptr() as *mut ffi::c_void,
> +                usize::div_ceil(self.nbits, bindings::BITS_PER_LONG as u=
size)
> +                    * bindings::BITS_PER_LONG as usize,

I think the second argument to `get_random_bytes` should be in bytes, not
bits. So it should be multiplied by "bytes per long", not "bits per long".

> +            );
> +        }
> +    }
>  }
>=20
>  impl CBitmap {
> --
> 2.49.0.1204.g71687c7c1d-goog

Cheers,
Pekka
