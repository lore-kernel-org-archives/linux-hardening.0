Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8C1E833D;
	Mon, 19 May 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676366; cv=none; b=EJPchPJy+WDwZ5z1tR4Dq3uRI1phwPr3nfVVlgHBNG6JV2QQDLvlPX+XZwkDu68FWuX4jhgriBnHvap6Xjb7ZxjYKUdsbgKvHF1Sw92dIyBkvnu91/g98SR2jaQGaw5JeXy312h/7NJvDTb8J9F1ANYigyPuqm8aGPRJwHnXI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676366; c=relaxed/simple;
	bh=MWElh7+L+WHmEbVBx+JO1axCQb8vStjXejhC6+uWO6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6/zRUcM4JN5xva3Ieb7zKobNar9brTbBvH763jR1esKr9PRDdUCgQlawy1aEFzPeK7Qnj9qZ1BY7BBDijQGLl80gF2IWn+ZzxFVEookVaG/QiT5K2+++oCTLvkIYGy1JcgHYlIyk8AFkIV5K0k32/joZTqus7kmqMfDoQPTcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJV8TE38; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJV8TE38"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231e011edfaso35870915ad.0;
        Mon, 19 May 2025 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747676364; x=1748281164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqH96lFJrunSkB8waBY3FqEiyTkUqVagz5gksV1z9Do=;
        b=WJV8TE38r3qFD+7lspT4np5sEP3i8NWuTEjEDg3v623w5A/3KmB/WEMAN17AqJicIO
         +nqq2MeHhaNg+tRtKff4590MNSqa5NPSPk4NNaF+lluiOVlxJcp20BUh5MCrp+KQUtEv
         Fcn0y8Be7KySQKwu7qHwQEkpbPp02ol/DUm3y/RiQ+t0dKumKCfdyaJp/A3MWhI5JBYe
         +KIB0Sfcb97syzoWTgSMQDV3UvGsRePjJlq0c1741UBka/diCiyx3DzjjMXjkY34cZCx
         R7vjaQWMA/kKi85n561lCigonrIWIr5s7PgXcoNs/25U4ARgvi2+oDt5jsQH1JpXwYa7
         wjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676364; x=1748281164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqH96lFJrunSkB8waBY3FqEiyTkUqVagz5gksV1z9Do=;
        b=k/A5KLr2ljGL03EnhLcDljoCOL132TpR7M6+of4bebqiJ18xx4I5oRHFh9aKsDqskH
         IInNnWQ25d3jxULEBg/l9pOeYVcD+N/LFDsw4ezSjwRTExPoQ870iBONzVEcCpoO3wLH
         RKgmZHDCfclRk92UYiVFgFqEOPuiZy6QR5IvjQfIAPVrmTl2Y9AT6PsAf0WjVer6cs+B
         QV1K/l7ap9HweuHt9mCladzb2uq+hfDuJfu+irtfLSDnbgyJRorhO1D2DnsUC01kacNh
         P3e1QY0jY0K7lZnALcE2LCkA9A8irwR2fzy7pK/2W5fFTvP3E6g3r7LUZlEdEw730/71
         bU+A==
X-Forwarded-Encrypted: i=1; AJvYcCWVmeBxm0WCWorICkf4MRD2VnZC+T72y94+gbtMd82GMMZR41EpHrz0K9symp8GYJMiQJffp73YsK/soYMG@vger.kernel.org, AJvYcCWrfCrH7i1bL31HXPtd8LpplgnnsDVyIEt/xdu/hKVPY0dOXwkgQ3PzTt0Bou413a/bSre3ONgBQy4UzeTNWBc=@vger.kernel.org, AJvYcCXv9yN4UV7Gci5qnBvU+FefGA9om+lE1DqC7xYJRaoXucRC+n41aOratsU/8c2d+3uNAuX1XoWYJuTbj7sLIEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u9qnBFVCsv1QNJJG3iLBgKxdNPvILV5+BYDOdc3lGTyQh6h4
	Qz8jMhR7SrAaK8JMRf7Niyec8XdfBorKov7K71hEkVNUTB59aJGjj6x6
X-Gm-Gg: ASbGncsyTYmrCU62zyFkjzjF02UITSTFHFcWI3MIdDB5tZewSMzASfHzT8DaltFKbZF
	hfG5euTrvvrzP/HssDuzWyEuHX+TJuHBEMQ2KjR2CVwgw6UKuLW1MCSkf1RKoVRU/SBcLzAspWz
	IHzvqnNFI6MfUZM5k/1FYnNvKLD42qtkzQzN3VBCjwTQJxwV7e6GZiqLRQvt8ex2VkE3aXcA1Q0
	X0iZP5C7jX96NI1vLmjPamybTWkc9/XG4CLOGoUgNXngCeujbiOYwqNwEIzr8mveeC54XimJ83e
	peqkHdv33WKlseVBMkZCKO5N/L9HMYgJTzN+DMHT+wTYrFlVPJo=
X-Google-Smtp-Source: AGHT+IGv6kLMhddLH8nklvlDYSAML91GwX3c9uWtTcWhB7LfFCs0tkmzp/GJdOluH2hGfBByqVZMag==
X-Received: by 2002:a17:902:d481:b0:232:4f8c:1b01 with SMTP id d9443c01a7336-2324f8c1cb2mr56440245ad.43.1747676363740;
        Mon, 19 May 2025 10:39:23 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9619sm62575655ad.37.2025.05.19.10.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:39:23 -0700 (PDT)
Date: Mon, 19 May 2025 13:39:20 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 4/5] rust: add find_bit_benchmark_rust module.
Message-ID: <aCtsyA6-kzNLlf4L@yury>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-5-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519161712.2609395-5-bqe@google.com>

On Mon, May 19, 2025 at 04:17:04PM +0000, Burak Emir wrote:
> Microbenchmark protected by a config FIND_BIT_BENCHMARK_RUST,
> following `find_bit_benchmark.c` but testing the Rust Bitmap API.

I already asked this: please print the output of this test together
wit C version, and please make sure it's collected on bare metal
machine.
 
> We add a fill_random() method protected by the config in order to
> maintain the abstraction.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS                     |  1 +
>  lib/Kconfig.debug               | 13 +++++
>  lib/Makefile                    |  1 +
>  lib/find_bit_benchmark_rust.rs  | 94 +++++++++++++++++++++++++++++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/bitmap.rs           | 14 +++++
>  6 files changed, 124 insertions(+)
>  create mode 100644 lib/find_bit_benchmark_rust.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 565eaa015d9e..943d85ed1876 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4132,6 +4132,7 @@ M:	Alice Ryhl <aliceryhl@google.com>
>  M:	Burak Emir <bqe@google.com>
>  R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
> +F:	lib/find_bit_benchmark_rust.rs
>  F:	rust/kernel/bitmap.rs
>  
>  BITOPS API
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f9051ab610d5..37a07559243e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2605,6 +2605,19 @@ config FIND_BIT_BENCHMARK
>  
>  	  If unsure, say N.
>  
> +config FIND_BIT_BENCHMARK_RUST

Shouldn't this depend on config RUST, and maybe something else?

> +	tristate "Test find_bit functions in Rust"
> +	help
> +	  This builds the "find_bit_benchmark_rust" module. It is a micro
> +          benchmark that measures the performance of Rust functions that
> +          correspond to the find_*_bit() operations in C. It follows the
> +          FIND_BIT_BENCHMARK closely but will in general not yield same
> +          numbers due to extra bounds checks and overhead of foreign
> +          function calls.
> +
> +	  If unsure, say N.
> +
> +
>  config TEST_FIRMWARE
>  	tristate "Test firmware loading via userspace interface"
>  	depends on FW_LOADER
> diff --git a/lib/Makefile b/lib/Makefile
> index f07b24ce1b3f..99e49a8f5bf8 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -62,6 +62,7 @@ obj-y += hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
>  obj-y += kstrtox.o
>  obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
> +obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) += find_bit_benchmark_rust.o
>  obj-$(CONFIG_TEST_BPF) += test_bpf.o
>  test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
>  obj-$(CONFIG_TEST_DHRY) += test_dhry.o
> diff --git a/lib/find_bit_benchmark_rust.rs b/lib/find_bit_benchmark_rust.rs
> new file mode 100644
> index 000000000000..13830477a8d2
> --- /dev/null
> +++ b/lib/find_bit_benchmark_rust.rs
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//! Benchmark for find_bit-like methods in Bitmap Rust API.
> +
> +use kernel::alloc::flags::GFP_KERNEL;
> +use kernel::bindings;
> +use kernel::bitmap::Bitmap;
> +use kernel::error::{code, Result};
> +use kernel::pr_err;
> +use kernel::prelude::module;
> +use kernel::time::Ktime;
> +use kernel::ThisModule;
> +
> +const BITMAP_LEN: usize = 4096 * 8 * 10;
> +// Reciprocal of the fraction of bits that are set in sparse bitmap.
> +const SPARSENESS: usize = 500;
> +
> +/// Test module that benchmarks performance of traversing bitmaps.
> +struct FindBitBenchmarkModule();
> +
> +fn test_next_bit(bitmap: &Bitmap) {
> +    let mut time = Ktime::ktime_get();
> +    let mut cnt = 0;
> +    let mut i = 0;
> +
> +    while let Some(index) = bitmap.next_bit(i) {
> +        cnt += 1;
> +        i = index + 1;
> +    }
> +
> +    time = Ktime::ktime_get() - time;
> +    pr_err!(
> +        "next_bit:           {:18} ns, {:6} iterations\n",
> +        time.to_ns(),
> +        cnt
> +    );
> +}
> +
> +fn test_next_zero_bit(bitmap: &Bitmap) {
> +    let mut time = Ktime::ktime_get();
> +    let mut cnt = 0;
> +    let mut i = 0;
> +
> +    while let Some(index) = bitmap.next_zero_bit(i) {
> +        cnt += 1;
> +        i = index + 1;
> +    }
> +
> +    time = Ktime::ktime_get() - time;
> +    pr_err!(
> +        "next_zero_bit:      {:18} ns, {:6} iterations\n",
> +        time.to_ns(),
> +        cnt
> +    );
> +}
> +
> +fn find_bit_test() {
> +    pr_err!("Start testing find_bit() Rust with random-filled bitmap\n");
> +
> +    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc bitmap failed");
> +    bitmap.fill_random();
> +
> +    test_next_bit(&bitmap);
> +    test_next_zero_bit(&bitmap);
> +
> +    pr_err!("Start testing find_bit() Rust with sparse bitmap\n");
> +
> +    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc sparse bitmap failed");
> +    let nbits = BITMAP_LEN / SPARSENESS;
> +    for _i in 0..nbits {
> +        // SAFETY: BITMAP_LEN fits in 32 bits.
> +        let bit: usize =
> +            unsafe { bindings::__get_random_u32_below(BITMAP_LEN.try_into().unwrap()) as _ };
> +        bitmap.set_bit(bit);
> +    }
> +
> +    test_next_bit(&bitmap);
> +    test_next_zero_bit(&bitmap);
> +}
> +
> +impl kernel::Module for FindBitBenchmarkModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        find_bit_test();
> +        // Return error so test module can be inserted again without rmmod.
> +        Err(code::EINVAL)
> +    }
> +}
> +
> +module! {
> +    type: FindBitBenchmarkModule,

Can you explain the meaning of 'type' section? To me your type is too
unique. This way, we'll end up having the number of types equal to
the number of modules.

Maybe just 'Benchmark'?

> +    name: "find_bit_benchmark_rust_module",
> +    authors: ["Rust for Linux Contributors"],

To me it's pretty useless. I think this 'authors' section exists to
help those having troubles with the module to reach the right people.
Can you please add your name and email here?

> +    description: "Module with benchmark for bitmap code!",
> +    license: "GPL v2",
> +}
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index b6bf3b039c1b..f6ca7f1dd08b 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -31,6 +31,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/poll.h>
>  #include <linux/property.h>
> +#include <linux/random.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 943dbef7948b..fb0c687420cd 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -124,6 +124,20 @@ pub fn len(&self) -> usize {
>          self.nbits
>      }
>  
> +    /// Fills this `Bitmap` with random bits.
> +    #[cfg(CONFIG_FIND_BIT_BENCHMARK_RUST)]
> +    pub fn fill_random(&mut self) {
> +        // SAFETY: `self.as_mut_ptr` points to either an array of the
> +        // appropriate length or one usize.
> +        unsafe {
> +            bindings::get_random_bytes(
> +                self.as_mut_ptr() as *mut ffi::c_void,
> +                usize::div_ceil(self.nbits, bindings::BITS_PER_LONG as usize)
> +                    * bindings::BITS_PER_LONG as usize,
> +            );
> +        }
> +    }
> +
>      /// Returns a mutable raw pointer to the backing [`Bitmap`].
>      #[inline]
>      fn as_mut_ptr(&mut self) -> *mut usize {
> -- 
> 2.49.0.1101.gccaa498523-goog
