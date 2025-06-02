Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D9221FD0
	for <linux-hardening@vger.kernel.org>; Mon,  2 Jun 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871428; cv=none; b=Lt/QqOpRedy/hnCrqcBvzO0vZothneA9fVqqXMvDWbHCG2KdlKy2+WmS7ylsbWA9nZsB47in48Q/aE6FblHOtMOuU1nactOHiO/Xzj0ul4/uICSzN/SuqftSZCEIvHCFECroBolngANq8ToQbVQdbFixWLO/XvZgWq37RQEYVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871428; c=relaxed/simple;
	bh=Cqzii58nVmE6Xjc0I4yziV5YigzMbAtsB8RogUbVtgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GALfCGJLoesw4njzbipB5lWmQMuhrr5qta1qxC3EVaxb3GxJq+SnbND/1SRZ++LvxugMQ4E4PCorUZa0lAga0DJcJZs05Ujyr8YiSuzRdwmM5dFhYJaxxRyWeco+FiBLNRpmqWsy0kUD1JqhIJA6HZ9wrdU7y4ARjVSU+R3ynn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoSN2jhr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoSN2jhr"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso23860625e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Jun 2025 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748871425; x=1749476225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcVakMlKYDO8yucN345y9x+THKYoIpGW6/IQj21Bs8c=;
        b=LoSN2jhrTL2bWn10W0T0f4ELXMWdklJGeBKHLhGbGNvkrspRx4Nm0yHMmyoFrS1QvC
         nKuawv7yT456WANMahmRvCzVSHjjMMkm95+zjsth7SCcsA8i2LprApOn0jpdoWOF54H2
         6MI8orAL3xYx/PCQjpT1ZbAYdmwgRHLkDp+sYgEYMwPeCk8vBpc4EDkDaqSlia7NzpoH
         gOHf9hL1rEcW/NLlCgLFe5Itgy5s01cN9gmMXxxiZfGKaQXeS1DWNHyLTs6iqrnjUhQF
         jUGQnUtcgU+oWF6qDYC5oKT9l3HUaC4+RvN0AEa7r+8+ARR0dq/Mr/uhGOhqJjr2rWyg
         vjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748871425; x=1749476225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcVakMlKYDO8yucN345y9x+THKYoIpGW6/IQj21Bs8c=;
        b=HMdl0TNV1t72PKu9qOEzdQ0iMnkMChEuqPumFaxEGJwPn6cfC03Y167Y7tCRtNrfQ7
         LhgNJmpsAwcBPfn58au5QZYmQqJDcAFJzoKCFDk+xo6ZlG/SDaQoSZ0shzxB24KnxZEH
         /3h2SiWiw1Eukk1JHnFsQlz+aqAGjFpp7ENspPrAkRwBg+yb8y0lc2IeGY3tm/ikcmN1
         SuLu3VpCCOWkl+vdOvuoLo2hbmG3KgUwMp/+02SQBaK24LAdIBMnJ9IEU/+pf+AXD/qo
         Gp/LyVAhzhY2vVvTNt0K2qs+iimmdaho+ybRPU9vzf2RTLRaVm1nuj3/qIWIcI3u61IT
         S0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXzmyrpBkDR+qNnJwUqVGFXFExxDp9Oc1dGR5hTqbB5U6dWvzlcRa8vSR0vpKUpQT7tpVvJi7mHVgIyR2zTm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIoqvK68hcCLNXM4vhdTx38pchwvQPRPvEt4mB+WL5s/liGnw
	TbPDQTvjS34byyd6ZCf/8JL6QqlVunkt8CWWV5CzYzwUmVNZaBVAU/cSB4iLsCbow5khyg==
X-Google-Smtp-Source: AGHT+IFb3l1kghpSN4ZINeIBahBXDBeeTyzt/dryW+DWckhRTNtnV2D19C5lIAPGWZBXUKCorl74PlE=
X-Received: from wmrn8.prod.google.com ([2002:a05:600c:5008:b0:451:d280:847])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a319:b0:43c:f509:2bbf
 with SMTP id 5b1f17b1804b1-450ce897c9dmr118880545e9.15.1748871425000; Mon, 02
 Jun 2025 06:37:05 -0700 (PDT)
Date: Mon,  2 Jun 2025 13:36:45 +0000
In-Reply-To: <20250602133653.1606388-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602133653.1606388-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602133653.1606388-5-bqe@google.com>
Subject: [PATCH v10 4/5] rust: add find_bit_benchmark_rust module.
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Microbenchmark protected by a config FIND_BIT_BENCHMARK_RUST,
following `find_bit_benchmark.c` but testing the Rust Bitmap API.

We add a fill_random() method protected by the config in order to
maintain the abstraction.

The sample output from the benchmark, both C and Rust version:

find_bit_benchmark.c output:
```
Start testing find_bit() with random-filled bitmap
[  438.101937] find_next_bit:                  860188 ns, 163419 iterations
[  438.109471] find_next_zero_bit:             912342 ns, 164262 iterations
[  438.116820] find_last_bit:                  726003 ns, 163419 iterations
[  438.130509] find_nth_bit:                  7056993 ns,  16269 iterations
[  438.139099] find_first_bit:                1963272 ns,  16270 iterations
[  438.173043] find_first_and_bit:           27314224 ns,  32654 iterations
[  438.180065] find_next_and_bit:              398752 ns,  73705 iterations
[  438.186689]
               Start testing find_bit() with sparse bitmap
[  438.193375] find_next_bit:                    9675 ns,    656 iterations
[  438.201765] find_next_zero_bit:            1766136 ns, 327025 iterations
[  438.208429] find_last_bit:                    9017 ns,    656 iterations
[  438.217816] find_nth_bit:                  2749742 ns,    655 iterations
[  438.225168] find_first_bit:                 721799 ns,    656 iterations
[  438.231797] find_first_and_bit:               2819 ns,      1 iterations
[  438.238441] find_next_and_bit:                3159 ns,      1 iterations
```

find_bit_benchmark_rust.rs output:
```
[  451.182459] find_bit_benchmark_rust_module:
[  451.186688] Start testing find_bit() Rust with random-filled bitmap
[  451.194450] next_bit:                       777950 ns, 163644 iterations
[  451.201997] next_zero_bit:                  918889 ns, 164036 iterations
[  451.208642] Start testing find_bit() Rust with sparse bitmap
[  451.214300] next_bit:                         9181 ns,    654 iterations
[  451.222806] next_zero_bit:                 1855504 ns, 327026 iterations
```

Here are the results from 32 samples, with 95% confidence interval.
The microbenchmark was built with RUST_BITMAP_HARDENED=n and run on a
machine that did not execute other processes.

Random-filled bitmap:
+-----------+-------+-----------+--------------+-----------+-----------+
| Benchmark | Lang  | Mean (ms) | Std Dev (ms) | 95% CI Lo | 95% CI Hi |
+-----------+-------+-----------+--------------+-----------+-----------+
| find_bit/ | C     |    825.07 |        53.89 |    806.40 |    843.74 |
| next_bit  | Rust  |    870.91 |        46.29 |    854.88 |    886.95 |
+-----------+-------+-----------+--------------+-----------+-----------+
| find_zero/| C     |    933.56 |        56.34 |    914.04 |    953.08 |
| next_zero | Rust  |    945.85 |        60.44 |    924.91 |    966.79 |
+-----------+-------+-----------+--------------+-----------+-----------+

Rust appears 5.5% slower for next_bit, 1.3% slower for next_zero.

Sparse bitmap:
+-----------+-------+-----------+--------------+-----------+-----------+
| Benchmark | Lang  | Mean (ms) | Std Dev (ms) | 95% CI Lo | 95% CI Hi |
+-----------+-------+-----------+--------------+-----------+-----------+
| find_bit/ | C     |     13.17 |         6.21 |     11.01 |     15.32 |
| next_bit  | Rust  |     14.30 |         8.27 |     11.43 |     17.17 |
+-----------+-------+-----------+--------------+-----------+-----------+
| find_zero/| C     |   1859.31 |        82.30 |   1830.80 |   1887.83 |
| next_zero | Rust  |   1908.09 |       139.82 |   1859.65 |   1956.54 |
+-----------+-------+-----------+--------------+-----------+-----------+

Rust appears 8.5% slower for next_bit, 2.6% slower for next_zero.

In summary, taking the arithmetic mean of all slow-downs, we can say
the Rust API has a 4.5% slowdown.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                     |  1 +
 lib/Kconfig.debug               | 13 +++++
 lib/Makefile                    |  1 +
 lib/find_bit_benchmark_rust.rs  | 95 +++++++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/bitmap.rs           | 14 +++++
 6 files changed, 125 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 565eaa015d9e..943d85ed1876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4132,6 +4132,7 @@ M:	Alice Ryhl <aliceryhl@google.com>
 M:	Burak Emir <bqe@google.com>
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	lib/find_bit_benchmark_rust.rs
 F:	rust/kernel/bitmap.rs
 
 BITOPS API
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..d8ed53f35495 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2605,6 +2605,19 @@ config FIND_BIT_BENCHMARK
 
 	  If unsure, say N.
 
+config FIND_BIT_BENCHMARK_RUST
+	tristate "Test find_bit functions in Rust"
+	depends on RUST
+	help
+	  This builds the "find_bit_benchmark_rust" module. It is a micro
+          benchmark that measures the performance of Rust functions that
+          correspond to the find_*_bit() operations in C. It follows the
+          FIND_BIT_BENCHMARK closely but will in general not yield same
+          numbers due to extra bounds checks and overhead of foreign
+          function calls.
+
+	  If unsure, say N.
+
 config TEST_FIRMWARE
 	tristate "Test firmware loading via userspace interface"
 	depends on FW_LOADER
diff --git a/lib/Makefile b/lib/Makefile
index f07b24ce1b3f..99e49a8f5bf8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -62,6 +62,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
+obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) += find_bit_benchmark_rust.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
diff --git a/lib/find_bit_benchmark_rust.rs b/lib/find_bit_benchmark_rust.rs
new file mode 100644
index 000000000000..468a2087f68c
--- /dev/null
+++ b/lib/find_bit_benchmark_rust.rs
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Benchmark for find_bit-like methods in Bitmap Rust API.
+
+use kernel::alloc::flags::GFP_KERNEL;
+use kernel::bindings;
+use kernel::bitmap::Bitmap;
+use kernel::error::{code, Result};
+use kernel::prelude::module;
+use kernel::time::Ktime;
+use kernel::ThisModule;
+use kernel::{pr_cont, pr_err};
+
+const BITMAP_LEN: usize = 4096 * 8 * 10;
+// Reciprocal of the fraction of bits that are set in sparse bitmap.
+const SPARSENESS: usize = 500;
+
+/// Test module that benchmarks performance of traversing bitmaps.
+struct FindBitBenchmarkModule();
+
+fn test_next_bit(bitmap: &Bitmap) {
+    let mut time = Ktime::ktime_get();
+    let mut cnt = 0;
+    let mut i = 0;
+
+    while let Some(index) = bitmap.next_bit(i) {
+        cnt += 1;
+        i = index + 1;
+    }
+
+    time = Ktime::ktime_get() - time;
+    pr_cont!(
+        "next_bit:           {:18} ns, {:6} iterations\n",
+        time.to_ns(),
+        cnt
+    );
+}
+
+fn test_next_zero_bit(bitmap: &Bitmap) {
+    let mut time = Ktime::ktime_get();
+    let mut cnt = 0;
+    let mut i = 0;
+
+    while let Some(index) = bitmap.next_zero_bit(i) {
+        cnt += 1;
+        i = index + 1;
+    }
+
+    time = Ktime::ktime_get() - time;
+    pr_cont!(
+        "next_zero_bit:      {:18} ns, {:6} iterations\n",
+        time.to_ns(),
+        cnt
+    );
+}
+
+fn find_bit_test() {
+    pr_err!("\n");
+    pr_cont!("Start testing find_bit() Rust with random-filled bitmap\n");
+
+    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc bitmap failed");
+    bitmap.fill_random();
+
+    test_next_bit(&bitmap);
+    test_next_zero_bit(&bitmap);
+
+    pr_cont!("Start testing find_bit() Rust with sparse bitmap\n");
+
+    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc sparse bitmap failed");
+    let nbits = BITMAP_LEN / SPARSENESS;
+    for _i in 0..nbits {
+        // SAFETY: BITMAP_LEN fits in 32 bits.
+        let bit: usize =
+            unsafe { bindings::__get_random_u32_below(BITMAP_LEN.try_into().unwrap()) as _ };
+        bitmap.set_bit(bit);
+    }
+
+    test_next_bit(&bitmap);
+    test_next_zero_bit(&bitmap);
+}
+
+impl kernel::Module for FindBitBenchmarkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        find_bit_test();
+        // Return error so test module can be inserted again without rmmod.
+        Err(code::EINVAL)
+    }
+}
+
+module! {
+    type: FindBitBenchmarkModule,
+    name: "find_bit_benchmark_rust_module",
+    authors: ["Burak Emir <bqe@google.com>"],
+    description: "Module with benchmark for bitmap Rust API",
+    license: "GPL v2",
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b6bf3b039c1b..f6ca7f1dd08b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/random.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 28c11e400d1e..9fefb2473099 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -252,6 +252,20 @@ pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
     pub fn len(&self) -> usize {
         self.nbits
     }
+
+    /// Fills this `Bitmap` with random bits.
+    #[cfg(CONFIG_FIND_BIT_BENCHMARK_RUST)]
+    pub fn fill_random(&mut self) {
+        // SAFETY: `self.as_mut_ptr` points to either an array of the
+        // appropriate length or one usize.
+        unsafe {
+            bindings::get_random_bytes(
+                self.as_mut_ptr() as *mut ffi::c_void,
+                usize::div_ceil(self.nbits, bindings::BITS_PER_LONG as usize)
+                    * bindings::BITS_PER_LONG as usize,
+            );
+        }
+    }
 }
 
 impl CBitmap {
-- 
2.49.0.1204.g71687c7c1d-goog

