Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B714883F
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261274; cv=none; b=HLl5+CKbGel/roXjIyBeLrKMM2fj24jYm0em2Jr6RxU68UuOjKtxRzyaYtL9Adk7l/kPZ9IA7vr4yXWGcasRiNu8pFo9Qn6uprYKGIX5VI4peYmfW2toEROL5qC3chlCNeJFz1bFZ52puvrqI0ZMv7Jn8eYmaUn45BT0BtgFrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261274; c=relaxed/simple;
	bh=PJOYGH8sm3tPcfyZPl+7nw5IqByaiIfj8mCvzJRbYk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OX2hAyht1aOfVOKiKIRcs3HVJNs30JnCZmg9fpuEOhXgs451juCazvcGfkIdvJGMzUUD8Dd50rlHA0RFIjB22sXTPNpbhQ/PjNph9GbBEunQwNKF8/bhnlJFLAKeiXU/tax1cTCmpfF9DssuQS7mXx6qazlOs3MTXfRlLVUo1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iz/Ysl5I; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iz/Ysl5I"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db70bf67faso67686387b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726261271; x=1726866071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1bBBq9kikheL0dQ08W3SkeOQIzgOcUwHx4tH8ueueI=;
        b=Iz/Ysl5I/rlkD+q0fAO3RAbgySqG+TyKTEqDuotnsxv93fg7CaY0vjdtFjCGI6s/m0
         mr/3tXysLA0PQ6sPbcs1r7Hq5K88NFvW/Ee6zyLpSQguAys5VxxOK/rINq8oUxSVYQkl
         ikWrQaGan06uG7ZuA6V7wKi73WPeGzDuMKNU0U5kznZp1jniZtUwmSt3iFwJGp7BdREH
         9w69do0T7J522eUbpCB26paFHrXcrfK8imtQxH4JpOZ59i5ZTEtLMp056OEzyx3Ng8ly
         vdEYrMUHzA1NpNUJWEVCC7BLaxUKr2CbYfyb7hE8MH2DRHGGjexmmPYBargoEyNDNTE7
         Ufew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726261271; x=1726866071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1bBBq9kikheL0dQ08W3SkeOQIzgOcUwHx4tH8ueueI=;
        b=TPJVTl/+vah6fGGb8eUsjAPnpkG9ICEV+DV9cMCu5Udp6Xod+41pS54k38g8bN4sA5
         WOueAC8fDMKHAXBv+qJ3oZle1nEv6Atjwl1vDq/tSs3nb5K7iHmwAPPVfwlh3c/kcaj+
         9pC2MODq9ak8izJfOcSUEeXEihHqIAUBjtBOrXlObQKNLVU01PMqLRGVvOsdzid1eIPQ
         p6+ebQNGfFEzWaTOgHY9qH79iLGuIKFu069qS/8HLI7EepKqs8AzGoZBp34Kz47DkZpe
         GA1tCdsWrfAD+YC2fQh/kF989AN4FX3a0V9SWSpdYN1C9O0VounzFONRFuI0UhtY8b2G
         +HoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVlVYmlvouPlHp1m5HycpNgjvr1jajjS8qRvIBCJDRSxMw7+biYAcumrOpTFwsv9X+aUblAYarfOWV7WQ3pi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBJCTowquS88lBAe4ZCFvsVxtPX3nc3bJbE5ciUnwCOwKK9Aq
	mBwo6qI2qELE52kz9gTsphAZxXsmIzCQ85RfyTWMQqEaQMcYh7TP0fztS3dJUXOPRlwYjiwoi3f
	+LyjUVFHXNdW1yw==
X-Google-Smtp-Source: AGHT+IFZN1KUhMwk8NdpZbk/+kD9l28IZLOsRm8n3dE8dVatCbwG9TrOt7m17nPie8ND8m7tHCK+uBDIy2CjM2g=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:48c4:b0:6b2:7ff8:ca3 with SMTP
 id 00721157ae682-6dbb6b85fe8mr5662537b3.4.1726261271572; Fri, 13 Sep 2024
 14:01:11 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:00:30 +0000
In-Reply-To: <20240913210031.20802-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240913210031.20802-1-aliceryhl@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=31783; i=aliceryhl@google.com;
 h=from:subject; bh=PJOYGH8sm3tPcfyZPl+7nw5IqByaiIfj8mCvzJRbYk4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5KVq/xjCm4VYCFACE7cMpANI65oTv4h0MJH0M
 SfQVwoVUqCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZuSlagAKCRAEWL7uWMY5
 RvmPEACiIn6oYHUr3bkQzzy06kHrlFlg/y8cfjrC7XpO8HumRE93t+ttwLy+HY0af+KdjWx1oEF
 y62RN8oTu1ebhvZbmb7IzDbE8opzHaht+85qrfAOClQdx4/HGKfy6jYh0X1yGaBthxLMN2+k23/
 0LDIqX+j22+0muIDjFaR1HWqKeiXPY+pDdUUsTF32BvuBGPZKigrjtGVPWxrBX7ReCPyGVqcQy9
 w5DbN53pNwBzUJbKJQOjCU6jhEBBPM2l7ng00YtEZoikI2TCpnOtVBe01iw9mlH/kz471kxRo5s
 QtdSNgemg7zJFj2aGnoEW65RPoFb+ZfuK53FzfJmPpTI1MsLC1JykCk2nGufytytVjNyCT/hQm1
 hE17wYffvJ5H4YoJkPIsZ80dSPMKhdtLhUxuAUgObLag6FrZ6Wu7dh2yPekqZB4HBPOCuc9JDxz
 uhK1AWHiaZb0dYnFQIgdhvj+BQazo4SXJAeJ159gNyzdPYL7LtWap83RoiEEaDeTpHHbnUBCHVs
 gzW72sj4iL9vY4QY846Cy54vpyEyEYiwLSuudxDM65uFybSSH6pBhl0YpXXBYpwveZ+1JKu+jm0
 naPs6E/U+YYqNOui1SY01PDt3JhiElHadW8auOGsQaBasfhoqkI2FWQlBxl8o4f+JKKykKvMHmw bzFdtvH5VRKry3w==
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913210031.20802-2-aliceryhl@google.com>
Subject: [RFC PATCH 2/2] rust_binder: use `Range` API when translating transactions
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

This RFC illustrates how my `Range` API can be used in Rust Binder.
Please see the other patch in this series for more information.

View this change on the web: https://r.android.com/3267276

Change-Id: I77b7ee3e734dc54975331620c49afe7713efc8a1
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/allocation.rs |  73 +++++----
 drivers/android/binder/error.rs      |   8 +
 drivers/android/binder/thread.rs     | 237 ++++++++++++++-------------
 3 files changed, 178 insertions(+), 140 deletions(-)

diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
index e552f3350f18..b8d6b27169e0 100644
--- a/drivers/android/binder/allocation.rs
+++ b/drivers/android/binder/allocation.rs
@@ -3,12 +3,12 @@
 // Copyright (C) 2024 Google LLC.
 
 use core::mem::{size_of, size_of_val, MaybeUninit};
-use core::ops::Range;
 
 use kernel::{
     bindings,
     fs::file::{File, FileDescriptorReservation},
     prelude::*,
+    range::{Range, RangeFixedSize, UsedRange},
     sync::Arc,
     types::{ARef, AsBytes, FromBytes},
     uaccess::UserSliceReader,
@@ -25,7 +25,7 @@
 #[derive(Default)]
 pub(crate) struct AllocationInfo {
     /// Range within the allocation where we can find the offsets to the object descriptors.
-    pub(crate) offsets: Option<Range<usize>>,
+    pub(crate) offsets: Option<core::ops::Range<usize>>,
     /// The target node of the transaction this allocation is associated to.
     /// Not set for replies.
     pub(crate) target_node: Option<NodeRef>,
@@ -81,7 +81,17 @@ pub(crate) fn new(
         }
     }
 
-    fn size_check(&self, offset: usize, size: usize) -> Result {
+    fn size_check(&self, range: Range) -> Result<UsedRange> {
+        let range = range.use_range();
+        let overflow_fail = range.offset.checked_add(range.length).is_none();
+        let cmp_size_fail = range.offset.wrapping_add(range.length) > self.size;
+        if overflow_fail || cmp_size_fail {
+            return Err(EFAULT);
+        }
+        Ok(range)
+    }
+
+    fn size_check2(&self, offset: usize, size: usize) -> Result<()> {
         let overflow_fail = offset.checked_add(size).is_none();
         let cmp_size_fail = offset.wrapping_add(size) > self.size;
         if overflow_fail || cmp_size_fail {
@@ -90,37 +100,35 @@ fn size_check(&self, offset: usize, size: usize) -> Result {
         Ok(())
     }
 
-    pub(crate) fn copy_into(
-        &self,
-        reader: &mut UserSliceReader,
-        offset: usize,
-        size: usize,
-    ) -> Result {
-        self.size_check(offset, size)?;
+    pub(crate) fn copy_into(&self, reader: &mut UserSliceReader, range: Range) -> Result {
+        let range = self.size_check(range)?;
 
         // SAFETY: While this object exists, the range allocator will keep the range allocated, and
         // in turn, the pages will be marked as in use.
         unsafe {
-            self.process
-                .pages
-                .copy_from_user_slice(reader, self.offset + offset, size)
+            self.process.pages.copy_from_user_slice(
+                reader,
+                self.offset + range.offset,
+                range.length,
+            )
         }
     }
 
     pub(crate) fn read<T: FromBytes>(&self, offset: usize) -> Result<T> {
-        self.size_check(offset, size_of::<T>())?;
+        self.size_check2(offset, size_of::<T>())?;
 
         // SAFETY: While this object exists, the range allocator will keep the range allocated, and
         // in turn, the pages will be marked as in use.
         unsafe { self.process.pages.read(self.offset + offset) }
     }
 
-    pub(crate) fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
-        self.size_check(offset, size_of_val::<T>(obj))?;
+    pub(crate) fn write<T: ?Sized>(&self, range: Range, obj: &T) -> Result {
+        range.assert_length_eq(size_of_val::<T>(obj))?;
+        let range = self.size_check(range)?;
 
         // SAFETY: While this object exists, the range allocator will keep the range allocated, and
         // in turn, the pages will be marked as in use.
-        unsafe { self.process.pages.write(self.offset + offset, obj) }
+        unsafe { self.process.pages.write(self.offset + range.offset, obj) }
     }
 
     pub(crate) fn fill_zero(&self) -> Result {
@@ -143,7 +151,7 @@ pub(crate) fn get_or_init_info(&mut self) -> &mut AllocationInfo {
         self.allocation_info.get_or_insert_with(Default::default)
     }
 
-    pub(crate) fn set_info_offsets(&mut self, offsets: Range<usize>) {
+    pub(crate) fn set_info_offsets(&mut self, offsets: core::ops::Range<usize>) {
         self.get_or_init_info().offsets = Some(offsets);
     }
 
@@ -172,13 +180,13 @@ pub(crate) fn info_add_fd_reserve(&mut self, num_fds: usize) -> Result {
     pub(crate) fn info_add_fd(
         &mut self,
         file: ARef<File>,
-        buffer_offset: usize,
+        range: Range,
         close_on_free: bool,
     ) -> Result {
         self.get_or_init_info().file_list.files_to_translate.push(
             FileEntry {
                 file,
-                buffer_offset,
+                range: RangeFixedSize::from_range(range)?,
                 close_on_free,
             },
             GFP_KERNEL,
@@ -206,8 +214,9 @@ pub(crate) fn translate_fds(&mut self) -> Result<TranslatedFds> {
         for file_info in files {
             let res = FileDescriptorReservation::get_unused_fd_flags(bindings::O_CLOEXEC)?;
             let fd = res.reserved_fd();
-            self.write::<u32>(file_info.buffer_offset, &fd)?;
-            crate::trace::trace_transaction_fd_recv(self.debug_id, fd, file_info.buffer_offset);
+            let range = file_info.range.into_range();
+            crate::trace::trace_transaction_fd_recv(self.debug_id, fd, range.peek_offset());
+            self.write::<u32>(range, &fd)?;
 
             reservations.push(
                 Reservation {
@@ -343,20 +352,26 @@ pub(crate) fn read<T: FromBytes>(&self, offset: usize) -> Result<T> {
         self.alloc.read(offset)
     }
 
-    pub(crate) fn write<T: AsBytes>(&self, offset: usize, obj: &T) -> Result {
-        if offset.checked_add(size_of::<T>()).ok_or(EINVAL)? > self.limit {
+    pub(crate) fn write<T: AsBytes>(&self, range: Range, obj: &T) -> Result {
+        range.assert_length_eq(size_of::<T>())?;
+        let end = range
+            .peek_offset()
+            .checked_add(size_of::<T>())
+            .ok_or(EINVAL)?;
+        if end > self.limit {
             return Err(EINVAL);
         }
-        self.alloc.write(offset, obj)
+        self.alloc.write(range, obj)
     }
 
     pub(crate) fn transfer_binder_object(
         &self,
-        offset: usize,
+        range: Range,
         obj: &bindings::flat_binder_object,
         strong: bool,
         node_ref: NodeRef,
     ) -> Result {
+        range.assert_length_eq(size_of::<FlatBinderObject>())?;
         let mut newobj = FlatBinderObject::default();
         let node = node_ref.node.clone();
         if Arc::ptr_eq(&node_ref.node.owner, &self.alloc.process) {
@@ -371,7 +386,7 @@ pub(crate) fn transfer_binder_object(
             newobj.flags = obj.flags;
             newobj.__bindgen_anon_1.binder = ptr as _;
             newobj.cookie = cookie as _;
-            self.write(offset, &newobj)?;
+            self.write(range, &newobj)?;
             // Increment the user ref count on the node. It will be decremented as part of the
             // destruction of the buffer, when we see a binder or weak-binder object.
             node.update_refcount(true, 1, strong);
@@ -390,7 +405,7 @@ pub(crate) fn transfer_binder_object(
             };
             newobj.flags = obj.flags;
             newobj.__bindgen_anon_1.handle = handle;
-            if self.write(offset, &newobj).is_err() {
+            if self.write(range, &newobj).is_err() {
                 // Decrement ref count on the handle we just created.
                 let _ = self
                     .alloc
@@ -561,7 +576,7 @@ struct FileEntry {
     /// The file for which a descriptor will be created in the recipient process.
     file: ARef<File>,
     /// The offset in the buffer where the file descriptor is stored.
-    buffer_offset: usize,
+    range: RangeFixedSize<4>,
     /// Whether this fd should be closed when the allocation is freed.
     close_on_free: bool,
 }
diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index dfce0c6270ca..8267134ff74b 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -67,6 +67,14 @@ fn from(source: kernel::fs::file::BadFdError) -> Self {
     }
 }
 
+impl From<kernel::range::RangeError> for BinderError {
+    #[track_caller]
+    fn from(source: kernel::range::RangeError) -> Self {
+        unsafe { kernel::bindings::dump_stack() };
+        BinderError::from(Error::from(source))
+    }
+}
+
 impl From<kernel::alloc::AllocError> for BinderError {
     fn from(_: kernel::alloc::AllocError) -> Self {
         Self {
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index ca1c85815bf8..ae796700cd6c 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -12,6 +12,7 @@
     fs::{File, LocalFile},
     list::{AtomicTracker, List, ListArc, ListLinks, TryNewListArc},
     prelude::*,
+    range::Range,
     security,
     seq_file::SeqFile,
     seq_print,
@@ -56,12 +57,10 @@ struct ScatterGatherState {
 struct ScatterGatherEntry {
     /// The index in the offset array of the BINDER_TYPE_PTR that this entry originates from.
     obj_index: usize,
-    /// Offset in target buffer.
-    offset: usize,
+    /// Range in the target buffer.
+    range: Range,
     /// User address in source buffer.
     sender_uaddr: usize,
-    /// Number of bytes to copy.
-    length: usize,
     /// The minimum offset of the next fixup in this buffer.
     fixup_min_offset: usize,
     /// The offsets within this buffer that contain pointers which should be translated.
@@ -170,15 +169,19 @@ fn validate_parent_fixup(
             return Err(EINVAL);
         }
         let new_min_offset = parent_offset.checked_add(length).ok_or(EINVAL)?;
-        if new_min_offset > sg_entry.length {
+        if new_min_offset > sg_entry.range.peek_length() {
             pr_warn!(
                 "validate_parent_fixup: new_min_offset={}, sg_entry.length={}",
                 new_min_offset,
-                sg_entry.length
+                sg_entry.range.peek_length()
             );
             return Err(EINVAL);
         }
-        let target_offset = sg_entry.offset.checked_add(parent_offset).ok_or(EINVAL)?;
+        let target_offset = sg_entry
+            .range
+            .peek_offset()
+            .checked_add(parent_offset)
+            .ok_or(EINVAL)?;
         // The `ancestors_i + 1` operation can't overflow since the output of the addition is at
         // most `self.ancestors.len()`, which also fits in a usize.
         Ok(ParentFixupInfo {
@@ -194,26 +197,20 @@ fn validate_parent_fixup(
 /// requested by the user using the `buffers_size` field of `binder_transaction_data_sg`. Each time
 /// we translate an object of type `BINDER_TYPE_PTR`, some of the unused buffer space is consumed.
 struct UnusedBufferSpace {
-    /// The start of the remaining space.
-    offset: usize,
-    /// The end of the remaining space.
-    limit: usize,
+    range: Range,
 }
 impl UnusedBufferSpace {
     /// Claim the next `size` bytes from the unused buffer space. The offset for the claimed chunk
     /// into the buffer is returned.
-    fn claim_next(&mut self, size: usize) -> Result<usize> {
+    fn claim_next(&mut self, size: usize) -> Result<Range> {
         // We require every chunk to be aligned.
-        let size = ptr_align(size);
-        let new_offset = self.offset.checked_add(size).ok_or(EINVAL)?;
+        let mut range = self.range.take_from_start(ptr_align(size))?;
 
-        if new_offset <= self.limit {
-            let offset = self.offset;
-            self.offset = new_offset;
-            Ok(offset)
-        } else {
-            Err(EINVAL)
-        }
+        // Truncate any extra bytes added for alignment.
+        range.truncate(size)?;
+
+        range.assert_aligned(size_of::<usize>())?;
+        Ok(range)
     }
 }
 
@@ -759,7 +756,7 @@ pub(crate) fn restore_priority(&self, desired: &BinderPriority) {
     fn translate_object(
         &self,
         obj_index: usize,
-        offset: usize,
+        obj_range: Range,
         object: BinderObjectRef<'_>,
         view: &mut AllocationView<'_>,
         allow_fds: bool,
@@ -778,7 +775,7 @@ fn translate_object(
                     .as_arc_borrow()
                     .get_node(ptr, cookie, flags, strong, self)?;
                 security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
-                view.transfer_binder_object(offset, obj, strong, node)?;
+                view.transfer_binder_object(obj_range, obj, strong, node)?;
             }
             BinderObjectRef::Handle(obj) => {
                 let strong = obj.hdr.type_ == BINDER_TYPE_HANDLE;
@@ -786,7 +783,7 @@ fn translate_object(
                 let handle = unsafe { obj.__bindgen_anon_1.handle } as _;
                 let node = self.process.get_node_from_handle(handle, strong)?;
                 security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
-                view.transfer_binder_object(offset, obj, strong, node)?;
+                view.transfer_binder_object(obj_range, obj, strong, node)?;
             }
             BinderObjectRef::Fd(obj) => {
                 if !allow_fds {
@@ -805,52 +802,61 @@ fn translate_object(
                     &file,
                 )?;
 
+                const FD_FIELD_OFFSET: usize =
+                    ::core::mem::offset_of!(bindings::binder_fd_object, __bindgen_anon_1.fd)
+                        as usize;
+
+                let fd_field_range = {
+                    // We're going to write to the fd field twice. Once now with u32::MAX, and
+                    // again later once we know what the actual fd is going to be.
+                    let mut range = obj_range.duplicate_range_careful();
+                    range.take_from_start(FD_FIELD_OFFSET)?;
+                    range.truncate(size_of::<u32>())?;
+                    range
+                };
+
                 let mut obj_write = BinderFdObject::default();
                 obj_write.hdr.type_ = BINDER_TYPE_FD;
                 // This will be overwritten with the actual fd when the transaction is received.
                 obj_write.__bindgen_anon_1.fd = u32::MAX;
                 obj_write.cookie = obj.cookie;
-                view.write::<BinderFdObject>(offset, &obj_write)?;
-
-                const FD_FIELD_OFFSET: usize =
-                    ::core::mem::offset_of!(bindings::binder_fd_object, __bindgen_anon_1.fd)
-                        as usize;
+                view.write::<BinderFdObject>(obj_range, &obj_write)?;
 
-                let field_offset = offset + FD_FIELD_OFFSET;
-                crate::trace::trace_transaction_fd_send(view.alloc.debug_id, fd, field_offset);
+                crate::trace::trace_transaction_fd_send(
+                    view.alloc.debug_id,
+                    fd,
+                    fd_field_range.peek_offset(),
+                );
 
-                view.alloc.info_add_fd(file, field_offset, false)?;
+                view.alloc.info_add_fd(file, fd_field_range, false)?;
             }
             BinderObjectRef::Ptr(obj) => {
                 let obj_length = obj.length.try_into().map_err(|_| EINVAL)?;
-                let alloc_offset = match sg_state.unused_buffer_space.claim_next(obj_length) {
+                let ptr_range = match sg_state.unused_buffer_space.claim_next(obj_length) {
                     Ok(alloc_offset) => alloc_offset,
                     Err(err) => {
                         pr_warn!(
-                            "Failed to claim space for a BINDER_TYPE_PTR. (offset: {}, limit: {}, size: {})",
-                            sg_state.unused_buffer_space.offset,
-                            sg_state.unused_buffer_space.limit,
+                            "Failed to claim space for a BINDER_TYPE_PTR. (size: {})",
                             obj_length,
                         );
                         return Err(err.into());
                     }
                 };
 
+                let buffer_ptr_in_user_space = (view.alloc.ptr + ptr_range.peek_offset()) as u64;
+
                 let sg_state_idx = sg_state.sg_entries.len();
                 sg_state.sg_entries.push(
                     ScatterGatherEntry {
                         obj_index,
-                        offset: alloc_offset,
+                        range: ptr_range,
                         sender_uaddr: obj.buffer as _,
-                        length: obj_length,
                         pointer_fixups: Vec::new(),
                         fixup_min_offset: 0,
                     },
                     GFP_KERNEL,
                 )?;
 
-                let buffer_ptr_in_user_space = (view.alloc.ptr + alloc_offset) as u64;
-
                 if obj.flags & bindings::BINDER_BUFFER_FLAG_HAS_PARENT == 0 {
                     sg_state.ancestors.clear();
                     sg_state.ancestors.push(sg_state_idx, GFP_KERNEL)?;
@@ -898,7 +904,7 @@ fn translate_object(
                 obj_write.length = obj.length;
                 obj_write.parent = obj.parent;
                 obj_write.parent_offset = obj.parent_offset;
-                view.write::<BinderBufferObject>(offset, &obj_write)?;
+                view.write::<BinderBufferObject>(obj_range, &obj_write)?;
             }
             BinderObjectRef::Fda(obj) => {
                 if !allow_fds {
@@ -949,10 +955,26 @@ fn translate_object(
                     return Err(EINVAL.into());
                 }
 
-                for i in (0..fds_len).step_by(size_of::<u32>()) {
+                // We're saving a fixup to skip this range in this buffer, so we won't actually use
+                // it twice.
+                //
+                // TODO: Move this logic to the code that performs fixups. That way, we can avoid
+                // duplicating this range.
+                let (_, mut fds_range) = parent_entry
+                    .range
+                    .duplicate_range_careful()
+                    .split_at(info.target_offset)?;
+                fds_range.truncate(fds_len)?;
+
+                for fd_range in fds_range.iter_chunks(size_of::<u32>())? {
                     let fd = {
+                        // We're not actually using the range to copy into the allocation here, so
+                        // this won't lead to double use of any indices.
+                        let start = fd_range.peek_offset() - info.target_offset;
+                        let end = fd_range.peek_end()? - info.target_offset;
+
                         let mut fd_bytes = [0u8; size_of::<u32>()];
-                        fd_bytes.copy_from_slice(&fda_bytes[i..i + size_of::<u32>()]);
+                        fd_bytes.copy_from_slice(&fda_bytes[start..end]);
                         u32::from_ne_bytes(fd_bytes)
                     };
 
@@ -968,7 +990,7 @@ fn translate_object(
 
                     // The `validate_parent_fixup` call ensuers that this addition will not
                     // overflow.
-                    view.alloc.info_add_fd(file, info.target_offset + i, true)?;
+                    view.alloc.info_add_fd(file, fd_range, true)?;
                 }
                 drop(fda_bytes);
 
@@ -977,45 +999,34 @@ fn translate_object(
                 obj_write.num_fds = obj.num_fds;
                 obj_write.parent = obj.parent;
                 obj_write.parent_offset = obj.parent_offset;
-                view.write::<BinderFdArrayObject>(offset, &obj_write)?;
+                view.write::<BinderFdArrayObject>(obj_range, &obj_write)?;
             }
         }
         Ok(())
     }
 
-    fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) -> BinderResult {
-        for sg_entry in &mut sg_state.sg_entries {
-            let mut end_of_previous_fixup = sg_entry.offset;
-            let offset_end = sg_entry.offset.checked_add(sg_entry.length).ok_or(EINVAL)?;
+    fn apply_sg(&self, alloc: &mut Allocation, sg_state: ScatterGatherState) -> BinderResult {
+        for sg_entry in sg_state.sg_entries {
+            let mut buffer_range = sg_entry.range;
 
-            let mut reader = UserSlice::new(sg_entry.sender_uaddr as _, sg_entry.length).reader();
-            for fixup in &mut sg_entry.pointer_fixups {
+            let mut reader =
+                UserSlice::new(sg_entry.sender_uaddr as _, buffer_range.peek_length()).reader();
+            for fixup in sg_entry.pointer_fixups {
                 let fixup_len = if fixup.skip == 0 {
                     size_of::<u64>()
                 } else {
                     fixup.skip
                 };
 
-                let target_offset_end = fixup.target_offset.checked_add(fixup_len).ok_or(EINVAL)?;
-                if fixup.target_offset < end_of_previous_fixup || offset_end < target_offset_end {
-                    pr_warn!(
-                        "Fixups oob {} {} {} {}",
-                        fixup.target_offset,
-                        end_of_previous_fixup,
-                        offset_end,
-                        target_offset_end
-                    );
-                    return Err(EINVAL.into());
-                }
+                let between_fixup_range = buffer_range.take_until(fixup.target_offset)?;
+                let fixup_range = buffer_range.take_from_start(fixup_len)?;
 
-                let copy_off = end_of_previous_fixup;
-                let copy_len = fixup.target_offset - end_of_previous_fixup;
-                if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
+                if let Err(err) = alloc.copy_into(&mut reader, between_fixup_range) {
                     pr_warn!("Failed copying into alloc: {:?}", err);
                     return Err(err.into());
                 }
                 if fixup.skip == 0 {
-                    let res = alloc.write::<u64>(fixup.target_offset, &fixup.pointer_value);
+                    let res = alloc.write::<u64>(fixup_range, &fixup.pointer_value);
                     if let Err(err) = res {
                         pr_warn!("Failed copying ptr into alloc: {:?}", err);
                         return Err(err.into());
@@ -1025,11 +1036,8 @@ fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) ->
                     pr_warn!("Failed skipping {} from reader: {:?}", fixup_len, err);
                     return Err(err.into());
                 }
-                end_of_previous_fixup = target_offset_end;
             }
-            let copy_off = end_of_previous_fixup;
-            let copy_len = offset_end - end_of_previous_fixup;
-            if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
+            if let Err(err) = alloc.copy_into(&mut reader, buffer_range) {
                 pr_warn!("Failed copying remainder into alloc: {:?}", err);
                 return Err(err.into());
             }
@@ -1066,16 +1074,15 @@ pub(crate) fn copy_transaction_data(
             None
         };
 
+        let secctx_size = secctx.as_ref().map(|(_, ctx)| ctx.len()).unwrap_or(0);
+
         let data_size = trd.data_size.try_into().map_err(|_| EINVAL)?;
         let aligned_data_size = ptr_align(data_size);
         let offsets_size = trd.offsets_size.try_into().map_err(|_| EINVAL)?;
         let aligned_offsets_size = ptr_align(offsets_size);
         let buffers_size = tr.buffers_size.try_into().map_err(|_| EINVAL)?;
         let aligned_buffers_size = ptr_align(buffers_size);
-        let aligned_secctx_size = secctx
-            .as_ref()
-            .map(|(_, ctx)| ptr_align(ctx.len()))
-            .unwrap_or(0);
+        let aligned_secctx_size = ptr_align(secctx_size);
 
         // This guarantees that at least `sizeof(usize)` bytes will be allocated.
         let len = usize::max(
@@ -1086,7 +1093,27 @@ pub(crate) fn copy_transaction_data(
                 .ok_or(ENOMEM)?,
             size_of::<usize>(),
         );
-        let secctx_off = aligned_data_size + aligned_offsets_size + aligned_buffers_size;
+
+        // Split the buffer size into sub-ranges.
+        let full_range = Range::new_area(len);
+        let (mut data_range, after_data) = full_range.split_within(aligned_data_size)?;
+        let (mut offsets_range, after_offsets) = after_data.split_within(aligned_offsets_size)?;
+        let (mut buffers_range, after_buffers) =
+            after_offsets.split_within(aligned_buffers_size)?;
+        let (mut secctx_range, _after_secctx) = after_buffers.split_within(aligned_secctx_size)?;
+
+        // Assert alignment.
+        data_range.assert_aligned(size_of::<usize>())?;
+        offsets_range.assert_aligned(size_of::<usize>())?;
+        buffers_range.assert_aligned(size_of::<usize>())?;
+        secctx_range.assert_aligned(size_of::<usize>())?;
+
+        // Truncate extra space added for the sake of alignment.
+        data_range.truncate(data_size)?;
+        offsets_range.truncate(offsets_size)?;
+        buffers_range.truncate(buffers_size)?;
+        secctx_range.truncate(secctx_size)?;
+
         let mut alloc =
             match to_process.buffer_alloc(debug_id, len, is_oneway, self.process.task.pid()) {
                 Ok(alloc) => alloc,
@@ -1106,62 +1133,55 @@ pub(crate) fn copy_transaction_data(
         // all bit-patterns.
         let trd_data_ptr = unsafe { &trd.data.ptr };
         let mut buffer_reader = UserSlice::new(trd_data_ptr.buffer as _, data_size).reader();
-        let mut end_of_previous_object = 0;
         let mut sg_state = None;
 
         // Copy offsets if there are any.
         if offsets_size > 0 {
             {
+                // We will first copy the offsets from userspace into the allocation, and then read
+                // the offsets again later down. Therefore, we need to duplicate the offsets range
+                // to use it twice.
+                let copy_range = offsets_range.duplicate_range_careful();
                 let mut reader = UserSlice::new(trd_data_ptr.offsets as _, offsets_size).reader();
-                alloc.copy_into(&mut reader, aligned_data_size, offsets_size)?;
+                alloc.copy_into(&mut reader, copy_range)?;
             }
 
-            let offsets_start = aligned_data_size;
-            let offsets_end = aligned_data_size + aligned_offsets_size;
-
             // This state is used for BINDER_TYPE_PTR objects.
             let sg_state = sg_state.insert(ScatterGatherState {
                 unused_buffer_space: UnusedBufferSpace {
-                    offset: offsets_end,
-                    limit: len,
+                    range: buffers_range,
                 },
                 sg_entries: Vec::new(),
                 ancestors: Vec::new(),
             });
 
+            let mut translated_offsets = offsets_range.peek_offset()..offsets_range.peek_offset();
+
             // Traverse the objects specified.
             let mut view = AllocationView::new(&mut alloc, data_size);
-            for (index, index_offset) in (offsets_start..offsets_end)
-                .step_by(size_of::<usize>())
-                .enumerate()
+            for (obj_index, index_range) in
+                offsets_range.iter_chunks(size_of::<usize>())?.enumerate()
             {
-                let offset = view.alloc.read(index_offset)?;
+                translated_offsets.end = index_range.peek_end()?;
+                let start_of_next_object = view.alloc.read(index_range.use_range().offset)?;
 
-                if offset < end_of_previous_object {
-                    pr_warn!("Got transaction with invalid offset.");
-                    return Err(EINVAL.into());
-                }
+                let (between_objs, data_rest) = data_range.split_at(start_of_next_object)?;
 
                 // Copy data between two objects.
-                if end_of_previous_object < offset {
-                    view.alloc.copy_into(
-                        &mut buffer_reader,
-                        end_of_previous_object,
-                        offset - end_of_previous_object,
-                    )?;
-                }
+                view.alloc.copy_into(&mut buffer_reader, between_objs)?;
 
                 let mut object = BinderObject::read_from(&mut buffer_reader)?;
+                let (obj_range, data_after_obj) = data_rest.split_within(object.size())?;
 
                 match self.translate_object(
-                    index,
-                    offset,
+                    obj_index,
+                    obj_range,
                     object.as_ref(),
                     &mut view,
                     allow_fds,
                     sg_state,
                 ) {
-                    Ok(()) => end_of_previous_object = offset + object.size(),
+                    Ok(()) => {}
                     Err(err) => {
                         pr_warn!("Error while translating object.");
                         return Err(err);
@@ -1169,20 +1189,15 @@ pub(crate) fn copy_transaction_data(
                 }
 
                 // Update the indexes containing objects to clean up.
-                let offset_after_object = index_offset + size_of::<usize>();
-                view.alloc
-                    .set_info_offsets(offsets_start..offset_after_object);
+                view.alloc.set_info_offsets(translated_offsets.clone());
+                data_range = data_after_obj;
             }
         }
 
         // Copy remaining raw data.
-        alloc.copy_into(
-            &mut buffer_reader,
-            end_of_previous_object,
-            data_size - end_of_previous_object,
-        )?;
+        alloc.copy_into(&mut buffer_reader, data_range)?;
 
-        if let Some(sg_state) = sg_state.as_mut() {
+        if let Some(sg_state) = sg_state {
             if let Err(err) = self.apply_sg(&mut alloc, sg_state) {
                 pr_warn!("Failure in apply_sg: {:?}", err);
                 return Err(err);
@@ -1190,11 +1205,11 @@ pub(crate) fn copy_transaction_data(
         }
 
         if let Some((off_out, secctx)) = secctx.as_mut() {
-            if let Err(err) = alloc.write(secctx_off, secctx.as_bytes()) {
+            **off_out = secctx_range.peek_offset();
+            if let Err(err) = alloc.write(secctx_range, secctx.as_bytes()) {
                 pr_warn!("Failed to write security context: {:?}", err);
                 return Err(err.into());
             }
-            **off_out = secctx_off;
         }
         Ok(alloc)
     }
-- 
2.46.0.662.g92d0881bb0-goog

