Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58F1A76DE;
	Wed, 17 Sep 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115615; cv=none; b=oIb0j5rTL8dXULOG5YkJwSzDUCBBOOymVK7RcdrIQ0GiHmmQmYFSIFDidR0Gj7ahtC6LAnAy9w2inm/i9//Y08GbDE0NrRiZsm+EmEgD+7Y9+s9YiR2yYTVjwtAFBytWerx5cqNZGA/ypUhAurofaXPa7dbKP6ALH4XJJk4IlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115615; c=relaxed/simple;
	bh=iUP8CJMIjPtCkCevxIoR3+jahqp22AVYpvNjPcCSOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmw6yJHNUEHwdjV67shDyHgYArummQJf+tOXSN2oxAfbqzw3J7Dggj+BUg7CANQd31ieq6fkv31vP77gLF5xbSaEUpmr1InTtCWm1rcvurgEQ+ItkRNU6yTOUruQu8yFC7Ejg5iJLRrD8LCCGFtbWvpNY432G3f0DYM4vNwy3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewFu/Oq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewFu/Oq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4B0C4CEF0;
	Wed, 17 Sep 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115615;
	bh=iUP8CJMIjPtCkCevxIoR3+jahqp22AVYpvNjPcCSOXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewFu/Oq88t1wv9kKa1KOJlxI7ymd3utJOVNw3PQ9vQx2trHoQGM6sSta8bkxFV7mE
	 9KXikfssThGFbnQfE9QkoLoQ/QR7MSOWII7lZHAM9SYJnuhc/17u5lulJbzAc32/zK
	 mEoCr1isBZe3FdwY78cgyz9WwfltW9hrrfPYPUP5Pgrhhaj9Lx6ikQap5sq9fuzVBb
	 VwgVJmOJQI+CSg9omxaVxArIrh5fgkRWV0X9jb2DT/OEPExoKQwgZJceEhFaL7diel
	 qfBpXonl/9CPC3YRIJfHDMy76+432/BO0wcycXLiTWY7BKrroXno+1Xfxtg6V7dM4i
	 NDaBXlVgzG2cw==
Date: Wed, 17 Sep 2025 15:26:49 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/2][next] stddef: Remove token-pasting in TRAILING_OVERLAP()
Message-ID: <13b3e0a69aad837b4e32ca8269b9d91bf1fbe9ef.1758115257.git.gustavoars@kernel.org>
References: <cover.1758115257.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758115257.git.gustavoars@kernel.org>

Currently, TRAILING_OVERLAP() token-pastes the FAM parameter into the
name of internal pdding member `__offset_to_##FAM`. This forces FAM to
be a single identifier, which prevents callers from using a FAM when
it's a nested member. For instance, see the following scenario:

| struct flex {
| 	size_t count;
| 	int data[];
| };

| struct foo {
| 	int hdr_foo;
| 	struct flex f;
| };

| struct composite {
| 	struct foo hdr;
| 	int data[100];
| };

In this case, it'd be useful if TRAILING_OVERLAP() could be used in
the following way:

| struct composite {
| 	TRAILING_OVERLAP(struct foo, hdr, f.data,
| 		int data[100];
| 	);
| };

However, this is not current possible due to the token concatenation
in `__offset_to_##FAM`, which fails when FAM contains a dot.

So, remove token-pasting and use the fixed internal name
`__offset_to_FAM` and, with this, expand the capabilities of
TRAILING_OVERLAP(). :)

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/stddef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index dab49e2ec8c0..701099c67c24 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -108,7 +108,7 @@ enum {
 	union {									\
 		TYPE NAME;							\
 		struct {							\
-			unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];	\
+			unsigned char __offset_to_FAM[offsetof(TYPE, FAM)];	\
 			MEMBERS							\
 		};								\
 	}
-- 
2.43.0

