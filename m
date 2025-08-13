Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF80273D8D
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099362; cv=none; b=AbNetlXOtTjCJygEDF9+SkTE5SWn+Cr4mqvxXZxxIsCDq+G/3mdK5iaMQW3bhTU+p1T+2YrlrhgGp0KNPtP7Qjt/2qokNHYo+QZAtKZXo6tmObezc2BQkg0oKJ3yXkYTrInGF5w6thhDINGvB89jCIrajFxoDk0sTWi+XIFZIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099362; c=relaxed/simple;
	bh=pYSqyLbGEOkp9MiVPkD6d88z2+rXjpa+i2Cy2Tbm1WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qT2lXj5TwAPZmFJr8GNc9PodtolIBP5jOuSdxskLf0NCktHBY2PbSTeCMRf3LSmicUdye4sk9wg3SGg1O8G4eHkONXW9nQz4BKwyjoPTLoGYwYUrQbbDQDyrRtEBc8uoRbv1BFjosNXcztKuyapngO0YHmPChXrbD97b1cL48NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jqong9Ns; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jqong9Ns"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-459de0d5fb1so51291945e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755099358; x=1755704158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wAb9+mVefgM/g0S0IITXMqNjygEyOxwctOAsMxRGu8=;
        b=Jqong9NsIwAXxI6yy84qAT4zB7xusndulUfj0r4sC8bFTIt0KscbanfJOOFHTcQ3gz
         9xZ2Z37ScVqTt3VU4pr+mqMlknu0KiUAvijApHfjVf4LGFZUk/8LteRi/d0mXQKtkhT7
         iSHFFE5p4kwg8txOjiMzR1syEQ+0mYB4Ex6hFb9VsA+FOTKqkkQQJ8rcTpv4U+aXJrhQ
         E0r5reu4FOUaTWS5zWD68JIiMGDPh8YMLwfqcUpKMQbo2bu7JQvuSct/1UhX/EtaihvK
         QwNsFApQ58eU3IAWSwnfawZm2LwKD0C+AFuL6sJlapabn+oxIZv7BAdb4Kj2TtgOa5ri
         5YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099358; x=1755704158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wAb9+mVefgM/g0S0IITXMqNjygEyOxwctOAsMxRGu8=;
        b=iPXORhVGMB5JqEMoB+klis8s0V6+eQVNNOaQibe518kJN6tdnnFQ/IXcLytf+0hZM8
         oXNPJBPmrXtsLQE+Xw+KMCbdNyButpQJDF/GPhwF9Hx2WVg5qaFYHIw8Ej5NCw42oZid
         mYIMdJXI3Wqbv/1m4y20p82d3nP0NMudip35OgjOt3moftSD9vZxl7utxs11y/mibaRG
         lt8N5Vbhd70Hs6t6srABQOg33tcAfciJGv0pa5svW9yKYOZJmy8RtTxx1I8F/3Br2Pnz
         ohJGUuivZ/gZ/BFfIT6iRa7W6iDU1/U5rbN/yM3cR9y4CFpq6JvvN/oUbc0s+zUnJCN9
         XgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpHKihUk02zfqYY30ZrcgNt5op/mSowUxCDPg4tq8+U5eYw2Le5O+KuIW49ENV0NpQmNPvHlpcA51QWciY8g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVQC7cCH2syxUej49RZ7LGlABe5KUERnKJuf5ttLhTyQgC2SZ
	A9do9ymDo6Wd5+i+sos6uym5oV74fA2r1lxOKHF776v39FgUckRoITsEKloYKVQ+DYWN+Q==
X-Google-Smtp-Source: AGHT+IFz51RtwEjUOWxOiNS5p9bPIxjtuQN8w5lwpgxOq2+IaeC15Xn2UgM8jyxrEnCM5dEe0dtfbJY=
X-Received: from wmcn17-n2.prod.google.com ([2002:a05:600c:c0d1:20b0:458:c02c:3ccd])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3ba0:b0:459:f90e:4f5a
 with SMTP id 5b1f17b1804b1-45a1a91d646mr3652385e9.15.1755099357866; Wed, 13
 Aug 2025 08:35:57 -0700 (PDT)
Date: Wed, 13 Aug 2025 15:35:45 +0000
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813153548.1650533-5-bqe@google.com>
Subject: [PATCH v14 4/5] rust: add find_bit_benchmark_rust module.
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
[  451.182459] find_bit_benchmark_rust:
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
Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                     |   1 +
 lib/Kconfig.debug               |  13 ++++
 lib/Makefile                    |   1 +
 lib/find_bit_benchmark_rust.rs  | 104 ++++++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/bitmap.rs           |  15 +++++
 6 files changed, 135 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1760df683cd2..f99e7f4eb4ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4306,6 +4306,7 @@ M:	Alice Ryhl <aliceryhl@google.com>
 M:	Burak Emir <bqe@google.com>
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	lib/find_bit_benchmark_rust.rs
 F:	rust/kernel/bitmap.rs
 
 BITOPS API
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed075..386232d81a0e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2607,6 +2607,19 @@ config FIND_BIT_BENCHMARK
 
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
index 392ff808c9b9..96a83b937a60 100644
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
index 000000000000..6bdc51de2f30
--- /dev/null
+++ b/lib/find_bit_benchmark_rust.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Benchmark for find_bit-like methods in Bitmap Rust API.
+
+use kernel::alloc::flags::GFP_KERNEL;
+use kernel::bindings;
+use kernel::bitmap::BitmapVec;
+use kernel::error::{code, Result};
+use kernel::prelude::module;
+use kernel::time::{Instant, Monotonic};
+use kernel::ThisModule;
+use kernel::{pr_cont, pr_err};
+
+const BITMAP_LEN: usize = 4096 * 8 * 10;
+// Reciprocal of the fraction of bits that are set in sparse bitmap.
+const SPARSENESS: usize = 500;
+
+/// Test module that benchmarks performance of traversing bitmaps.
+struct Benchmark();
+
+fn test_next_bit(bitmap: &BitmapVec) {
+    let time = Instant::<Monotonic>::now();
+    let mut cnt = 0;
+    let mut i = 0;
+
+    while let Some(index) = bitmap.next_bit(i) {
+        cnt += 1;
+        i = index + 1;
+        // CONFIG_RUST_BITMAP_HARDENED enforces strict bounds.
+        if i == BITMAP_LEN {
+            break;
+        }
+    }
+
+    let delta = time.elapsed();
+    pr_cont!(
+        "\nnext_bit:           {:18} ns, {:6} iterations",
+        delta.as_nanos(),
+        cnt
+    );
+}
+
+fn test_next_zero_bit(bitmap: &BitmapVec) {
+    let time = Instant::<Monotonic>::now();
+    let mut cnt = 0;
+    let mut i = 0;
+
+    while let Some(index) = bitmap.next_zero_bit(i) {
+        cnt += 1;
+        i = index + 1;
+        // CONFIG_RUST_BITMAP_HARDENED enforces strict bounds.
+        if i == BITMAP_LEN {
+            break;
+        }
+    }
+
+    let delta = time.elapsed();
+    pr_cont!(
+        "\nnext_zero_bit:      {:18} ns, {:6} iterations",
+        delta.as_nanos(),
+        cnt
+    );
+}
+
+fn find_bit_test() {
+    pr_err!("Benchmark");
+    pr_cont!("\nStart testing find_bit() Rust with random-filled bitmap");
+
+    let mut bitmap = BitmapVec::new(BITMAP_LEN, GFP_KERNEL).expect("alloc bitmap failed");
+    bitmap.fill_random();
+
+    test_next_bit(&bitmap);
+    test_next_zero_bit(&bitmap);
+
+    pr_cont!("\nStart testing find_bit() Rust with sparse bitmap");
+
+    let mut bitmap = BitmapVec::new(BITMAP_LEN, GFP_KERNEL).expect("alloc sparse bitmap failed");
+    let nbits = BITMAP_LEN / SPARSENESS;
+    for _i in 0..nbits {
+        // SAFETY: __get_random_u32_below is safe to call with any u32 argument.
+        let bit =
+            unsafe { bindings::__get_random_u32_below(BITMAP_LEN.try_into().unwrap()) as usize };
+        bitmap.set_bit(bit);
+    }
+
+    test_next_bit(&bitmap);
+    test_next_zero_bit(&bitmap);
+    pr_cont!("\n");
+}
+
+impl kernel::Module for Benchmark {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        find_bit_test();
+        // Return error so test module can be inserted again without rmmod.
+        Err(code::EINVAL)
+    }
+}
+
+module! {
+    type: Benchmark,
+    name: "find_bit_benchmark_rust",
+    authors: ["Burak Emir <bqe@google.com>"],
+    description: "Module with benchmark for bitmap Rust API",
+    license: "GPL v2",
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7bb575043c86..5d58316f871e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -67,6 +67,7 @@
 #include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/random.h>
 #include <linux/refcount.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 9235808dc03c..6e0824579781 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -252,6 +252,21 @@ pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
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
+                self.as_mut_ptr().cast::<ffi::c_void>(),
+                usize::div_ceil(self.nbits, bindings::BITS_PER_LONG as usize)
+                    * bindings::BITS_PER_LONG as usize
+                    / 8,
+            );
+        }
+    }
 }
 
 impl Bitmap {
-- 
2.51.0.rc0.205.g4a044479a3-goog

