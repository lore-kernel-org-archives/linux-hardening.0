Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CB13CF86
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261262; cv=none; b=kLEGoqy0ZaKUwAZNTTtxaUNLqir51bKJaEx+X8df1ncXBSh4aY79pp9NWbcZfcgAQC1TkHHEGL5okDa5AimefAPu5Eum0qKKiSUQV0KDJcL/ChNQJkkuEi0MtcgBGIxahk7fYiU4ErTjyO90Wi8PMQ6kb3IALVD44Bchto6lJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261262; c=relaxed/simple;
	bh=Bsq1xEuw6ejf6xS3xANARgXaND9lpmiO/KJqmLEaZQw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bm5serrhyqqP9m2i0dqxPr7hkdg+CM74zAPaGxZSvfAZcWao2CyB9O6yVsEIBtvM1MD85TaSlhyOZXBDoLqFe/sHqBUH7sbUZt2LoN1GjfG+Ta3MkunZtqLm0vLYIzmVhS1a2pDlccOe9lqbZbhj0e1DB4H9wAFcIb+r5Ys39Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qN98nIxD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qN98nIxD"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso5047387276.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726261259; x=1726866059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JOjhO68VsW+Q44c9vxTifNEWOZBiXq84OSMhawJSCm8=;
        b=qN98nIxDBGH5L15YrPo+991vk1PQaM2Mn5/5NwBms9WgZTTidmgcIM2rQTV8GFAjaz
         xswoYMnR98hgyJjReN5rVFQs4ZF1B6eDTMPw0SimnCrXgXyw6bSOxXp8J6XHBo77WiAH
         D/EhQ9mei6+4XCYXM6nLdygopgneamiE8eX5w3d2K24a4+RWhCMacpSty9wodlX3QP97
         FYiu+yIdY2GGugwQ6XA5xgfWexqOfZp/5s3DAKWbvckAsPrv5GLlowJfFcLDWOGErrIq
         HC4QE75u0Nnal03i4zxOJ5P7XarcdOFIX8E/6ehfM6T4r17sYDTbC20V0Vvix1ELJJNF
         sPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726261259; x=1726866059;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOjhO68VsW+Q44c9vxTifNEWOZBiXq84OSMhawJSCm8=;
        b=NrPfRsf5gCZuyxTwy5Oy2Zi/k/UjExi3hVS83U2c3VoulRiuwqsZ3BCzFy2ALZZQS0
         l0MG/68Q+1NE0NYPqUf7PDB/aKN4KcnEM3DyJOesdohgdTFmbMkEn0QJfHvGwFluk9Kq
         SNiENKCNex3cJD3RuMFg2RPfXNHZEzcctMDsDSDAgK9fYfHVbl3hAXXArGTQSSpYjMwT
         vNe0L05FgqSgj5yzq1j0caGrcr5y/1tK0pC0MEXSZ9gVlHaJGZwKRKNcAw/1zyKdStPZ
         tuW8sfj9OBhBwH8gWti5uNIM/6G4gk5q6EhemWUupMX9UZPbcoRDXiN73v3hXNH0d/Zv
         jemg==
X-Forwarded-Encrypted: i=1; AJvYcCUF6vem1CrF1tRtCIdrXo4TMZUZQkj38ZFt0ieB8OHNSiUKob5t96sbkJC9xUYozmUD7vCiQ7d/pjI9q62bEww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSuNXGFSboO9erJ1bLeVrKL8uGrmp1XP2Y3I/VqRvAgSd6y5p
	WyEAfSUmv3uePuz60N6OnM5JaO9uNmn0BlylCa/fWslX+PdsxMJj5/fOjUErkHLTgX27ZQ+Hchv
	91xT7U8+GCZyERw==
X-Google-Smtp-Source: AGHT+IE78DqEMn1x4D65+Oh79baqNb4ga4Il2b4TZCRvJqsZSc62M4hKIA8WtuEnZU3vVeN7NcM802z1zQlvJD0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1743:b0:e03:3cfa:1aa7 with SMTP
 id 3f1490d57ef6-e1d9db9e1b8mr9952276.1.1726261259177; Fri, 13 Sep 2024
 14:00:59 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:00:29 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13917; i=aliceryhl@google.com;
 h=from:subject; bh=Bsq1xEuw6ejf6xS3xANARgXaND9lpmiO/KJqmLEaZQw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5KVfe1mlk3eGa5gVeLGqw7Xv6jTFstXhpxq8H
 9z6t88w6qeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZuSlXwAKCRAEWL7uWMY5
 Ro9SEACX5vjaGSujAzvJt0UxP23WeMGhy5m7v99K5ys+26eCi4SpFoLEHSLEzKLMHXqtep1MOo+
 EOR+OY/OX+xjyf8HdzzqjM6mPp0EIsq4rcsDTupFWFK84MApjkVRJuboXg8x5Ugp163Ne3tcMwF
 mlzxR7STFFmBDD2RYTlJI073bwUTM3GuMTKvgls7456bC8hyZdYKhZCy0COXoDyXBwF1kCBh61z
 0aofaXa7d+102I0EZ7rkVaVX/2fZfteT9nzhXCEZF0WiflBI4BhRploL/N1D7i3WfRWucOlIrG5
 oVKTBrh22MPKbS35fzzGsfoAE8L15FesD8X0tGGWh0I49f6gtXEdttdNha7uoL8mJH3HScHpokv
 8RzvMbVAgpL8JvEcTKyNvY6WiJkmStfUaR4PbtHWZCD5GR3NuiJ90NHE3L27Q2OHnjNiw64YFOB
 vTIRPzIJji66/9kDdd7VdEyOAcgaRXbx4FXc6pYSyhYyqc8QtxJzWv+A5Gz2UX8d+qwtJRUeBki
 PI2+pxmPvghNLOi1ATzQHNwZ2kV9+2jFZtMRVv82ObP7zj2QBtQruPeKgGs4OdWyvXmwidP5cg3
 9Zo8we3EbgMEp5g1n2U/7RLM2ZFn0d6+ew40YKCLIoO8XZq2c0knYjfIeQ2VIAKIGMfTfFK4pUZ BI4avkwxTjPAnWQ==
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913210031.20802-1-aliceryhl@google.com>
Subject: [PATCH 1/2] rust: harden index manipulation using ownership
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Trevor Gross <tmgross@umich.edu>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

Rust is very effective at preventing memory safety bugs such as
use-after-free bugs. Can we also make it effective at preventing bugs
that arise from using indices incorrectly? As it stands today, accessing
an array out of bounds is caught and results in a kernel panic, but Rust
will not stop you from doing it. Accessing an array at the wrong index
is not caught at all. This patch explores ways to catch these kinds of
indexing bugs.

The Android Binder driver has a component where it "translates" the
contents of transactions sent using the driver, which involves complex
and error-prone index manipulation. The C driver has had several bugs in
this area. A few examples:

4df153652cc4 ("binder: fix UAF caused by offsets overwrite")
bdc1c5fac982 ("binder: fix UAF caused by faulty buffer cleanup")
16981742717b ("binder: fix incorrect calculation for num_valid")
a56587065094 ("binder: Set end of SG buffer area properly.")

Rust is not immune to these issues either. In fact, I've already
encountered and fixed two bugs like this in Rust Binder. In both cases,
the bugs could result in `Allocation::cleanup_object` calls on invalid
data. Rust's safety guarantees prevented these bugs from affecting the
integrity of kernel itself, but an attacker could use them to e.g.
manipulate handles that are present in other processes and for example
obtaining IApplicationThread handle belonging to another app from
system_server, which in turn allows loading code into that app.

Ultimately, the root cause of all of these bugs is that there is some
index in the destination buffer that gets written to twice.

The primary idea of this new Range API is to utilize Rust's ownership
semantics to prevent reuse of indices. The idea is that you create one
big Range for the entire range of indices, and then there are various
methods to split it into smaller ranges. An example from Rust Binder,
where several kinds of data are stored next to each other:

// Split the buffer size into sub-ranges.
let full_range = Range::new_area(len);
let (data_range, after_data) = full_range.split_within(aligned_data_size)?;
let (offsets_range, after_offsets) = after_data.split_within(aligned_offsets_size)?;
let (buffers_range, after_buffers) = after_offsets.split_within(aligned_buffers_size)?;
let (secctx_range, after_secctx) = after_buffers.split_within(aligned_secctx_size)?;
after_secctx.assert_empty()?;

The Range type is set up so that it cannot be copied or cloned, which
means that any attempts to use a Range more than once will fail to
compile. For example, if the line creating `buffers_range` accidentally
tried to split `after_data` instead of `after_offsets`, then that would
lead to this compilation error:

error[E0382]: use of moved value: `after_data`
    --> /usr/local/google/home/aliceryhl/rust-android-mainline/common/drivers/android/binder/thread.rs:1101:50
     |
1099 | let (data_range, after_data) = full_range.split_within(aligned_data_size)?;
     |                  ---------- move occurs because `after_data` has type `kernel::range::Range`, which does not implement the `Copy` trait
1100 | let (offsets_range, after_offsets) = after_data.split_within(aligned_offsets_size)?;
     |                                                 ---------------------------------- `after_data` moved due to this method call
1101 | let (buffers_range, after_buffers) = after_data.split_within(aligned_buffers_size)?;
     |                                      ^^^^^^^^^^ value used here after move
     |
note: `kernel::range::Range::split_within` takes ownership of the receiver `self`, which moves `after_data`
    --> /usr/local/google/home/aliceryhl/rust-android-mainline/common/rust/kernel/range.rs:108:29
     |
108  | pub fn split_within(mut self, length: usize) -> Result<(Range, Range), RangeError> {
     |                         ^^^^

Basically, the error says that you tried to use the `after_data` range
twice, which is not allowed because `split_within` destroys the object
you call it on.

In Rust Binder, I am using the ranges to prevent reuse of indices in the
*destination* buffer. To enforce that, all methods for writing to the
destination buffer are modified to take a `Range` as an argument,
consuming the range being written to. As ranges can only be split into
smaller pieces, this enforces that you will never write to the same
index twice.

Of course, the API is not completely bullet-proof. If you call
`Range::new_area` twice, you'll get two overlapping ranges. But we don't
need it to be completely impossible to misuse. It just needs to be
really difficult to do so accidentally.

Binder has one case where it intentionally writes to the same location
twice: when sending file descriptors over Binder, the driver does not
know what value the fd will have when transferring the data, so it will
first write u32::MAX. Much later, it will overwrite it with the real fd.
There is a `duplicate_range_careful` method for this case.

It is interesting to compare with the uaccess patchset [1]. The uaccess
API takes a userspace pointer and length representing a range of bytes
in userspace, and lets you read the range incrementally. The API design
prevents reading the same address twice. This helps prevent
time-of-check-to-time-of-use bugs where userspace modifies the data in
between two reads, which can cause bugs if the driver assumes that the
memory is unchanged.

In fact, both Rust Binder bugs mentioned earlier are caught by this part
of the uaccess API, as both bugs eventually attempt to read past the end
of the userspace region, triggering an error. Unfortunately, this
happens too late, as the previously translated data has already been
overwritten by the time the error is triggered.

This patchset is also simliar to Benno's untrusted data patchset [2],
which explores a different way to write misuse-resistant APIs.

Link: https://lore.kernel.org/r/20240528-alice-mm-v7-0-78222c31b8f4@google.com [1]
Link: https://lore.kernel.org/r/20240913112643.542914-1-benno.lossin@proton.me [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs   |   1 +
 rust/kernel/range.rs | 236 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 rust/kernel/range.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a7fefc4ae725..72a998cd02e0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -48,6 +48,7 @@
 pub mod page;
 pub mod prelude;
 pub mod print;
+pub mod range;
 pub mod rbtree;
 pub mod security;
 pub mod seq_file;
diff --git a/rust/kernel/range.rs b/rust/kernel/range.rs
new file mode 100644
index 000000000000..8fb9d96ac724
--- /dev/null
+++ b/rust/kernel/range.rs
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Utilities for working with ranges of indices.
+
+/// A range of indices.
+///
+/// This utility is useful for ensuring that no index in the range is used more than once.
+#[derive(Debug)]
+pub struct Range {
+    offset: usize,
+    length: usize,
+}
+
+impl Range {
+    /// Creates a new `Range` for an area of the given size.
+    pub fn new_area(size: usize) -> Self {
+        Self {
+            offset: 0,
+            length: size,
+        }
+    }
+
+    /// Use this range of indices.
+    ///
+    /// This destroys the `Range` object, so these indices cannot be used again after this call.
+    pub fn use_range(self) -> UsedRange {
+        UsedRange {
+            offset: self.offset,
+            length: self.length,
+        }
+    }
+
+    /// Duplicate this range.
+    ///
+    /// Be careful when using this method, as it allows you to use a range twice.
+    pub fn duplicate_range_careful(&self) -> Range {
+        Range {
+            offset: self.offset,
+            length: self.length,
+        }
+    }
+
+    /// Peek at the offset without using the range.
+    ///
+    /// This doesn't destroy the `Range` object, so be careful that the range is not used twice.
+    pub fn peek_offset(&self) -> usize {
+        self.offset
+    }
+
+    /// Peek at the length without using the range.
+    ///
+    /// This doesn't destroy the `Range` object, so be careful that the range is not used twice.
+    pub fn peek_length(&self) -> usize {
+        self.length
+    }
+
+    /// Peek at the end without using the range.
+    ///
+    /// This doesn't destroy the `Range` object, so be careful that the range is not used twice.
+    pub fn peek_end(&self) -> Result<usize, RangeError> {
+        self.offset.checked_add(self.length).ok_or(RangeError)
+    }
+
+    /// Truncates this range to the given length.
+    pub fn truncate(&mut self, length: usize) -> Result<(), RangeError> {
+        if length > self.length {
+            return Err(RangeError);
+        }
+        self.length = length;
+        Ok(())
+    }
+
+    /// Assert that this range is aligned properly.
+    pub fn assert_aligned(&self, alignment: usize) -> Result<(), RangeError> {
+        if self.offset % alignment == 0 {
+            Ok(())
+        } else {
+            Err(RangeError)
+        }
+    }
+
+    /// Assert that this range has the expected length.
+    pub fn assert_length_eq(&self, length: usize) -> Result<(), RangeError> {
+        if self.length == length {
+            Ok(())
+        } else {
+            Err(RangeError)
+        }
+    }
+
+    /// Assert that this range is empty.
+    pub fn assert_empty(self) -> Result<(), RangeError> {
+        self.assert_length_eq(0)
+    }
+
+    /// Splits the range into two sub-ranges.
+    ///
+    /// Fails if the `length` is greater than the range being split.
+    pub fn split_within(mut self, length: usize) -> Result<(Range, Range), RangeError> {
+        let left = self.take_from_start(length)?;
+        Ok((left, self))
+    }
+
+    /// Splits the range into two sub-ranges.
+    ///
+    /// Fails if the `position` is not within the current range.
+    pub fn split_at(mut self, position: usize) -> Result<(Range, Range), RangeError> {
+        let left = self.take_until(position)?;
+        Ok((left, self))
+    }
+
+    /// Modify this range by taking the first `length` bytes.
+    pub fn take_until(&mut self, position: usize) -> Result<Range, RangeError> {
+        let from_start = Range {
+            offset: self.offset,
+            length: position.checked_sub(self.offset).ok_or(RangeError)?,
+        };
+
+        let new_self = Range {
+            offset: position,
+            length: self
+                .length
+                .checked_sub(from_start.length)
+                .ok_or(RangeError)?,
+        };
+
+        *self = new_self;
+
+        Ok(from_start)
+    }
+
+    /// Modify this range by taking the first `length` bytes.
+    pub fn take_from_start(&mut self, length: usize) -> Result<Range, RangeError> {
+        let from_start = Range {
+            offset: self.offset,
+            length: length,
+        };
+
+        let new_self = Range {
+            offset: self.offset.checked_add(length).ok_or(RangeError)?,
+            length: self.length.checked_sub(length).ok_or(RangeError)?,
+        };
+
+        *self = new_self;
+
+        Ok(from_start)
+    }
+
+    /// Split this range into sub-ranges of the given size.
+    pub fn iter_chunks(self, chunk_size: usize) -> Result<ChunkIter, RangeError> {
+        if self.length % chunk_size != 0 {
+            return Err(RangeError);
+        }
+
+        Ok(ChunkIter {
+            pos: self.offset,
+            end: self.offset.checked_add(self.length).ok_or(RangeError)?,
+            chunk_size,
+        })
+    }
+}
+
+/// An iterator over ranges of the same size.
+pub struct ChunkIter {
+    pos: usize,
+    end: usize,
+    chunk_size: usize,
+}
+
+impl Iterator for ChunkIter {
+    type Item = Range;
+    fn next(&mut self) -> Option<Range> {
+        if self.pos >= self.end {
+            return None;
+        }
+
+        let range = Range {
+            offset: self.pos,
+            length: self.chunk_size,
+        };
+        self.pos = self.pos + self.chunk_size;
+
+        Some(range)
+    }
+}
+
+/// A version of [`Range`] where the length is a compile-time constant.
+///
+/// This can be used to store a `Range` without using up space to store the length.
+pub struct RangeFixedSize<const LENGTH: usize> {
+    offset: usize,
+}
+
+impl<const LENGTH: usize> RangeFixedSize<LENGTH> {
+    /// Create a `RangeFixedSize` from a `Range`.
+    pub fn from_range(range: Range) -> Result<Self, RangeError> {
+        if range.length == LENGTH {
+            Ok(Self {
+                offset: range.offset,
+            })
+        } else {
+            Err(RangeError)
+        }
+    }
+
+    /// Convert this back into a `Range`.
+    pub fn into_range(self) -> Range {
+        Range {
+            offset: self.offset,
+            length: LENGTH,
+        }
+    }
+}
+
+/// The return value of [`Range::use_range`].
+///
+/// The only way to access the indices in a range is to mark it "used", which converts it into this
+/// type, destroying the original [`Range`] object.
+#[derive(Copy, Clone)]
+pub struct UsedRange {
+    /// The offset of this range.
+    pub offset: usize,
+    /// The length of this range.
+    pub length: usize,
+}
+
+/// The error type returned when ranges are used incorrectly.
+pub struct RangeError;
+
+impl From<RangeError> for crate::error::Error {
+    fn from(_range: RangeError) -> crate::error::Error {
+        crate::error::code::EINVAL
+    }
+}
-- 
2.46.0.662.g92d0881bb0-goog

