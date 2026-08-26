Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50E3BB68F
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781714; cv=none; b=bXLvndgUVKt2lfPffnlDOSO2tm2Zo16NvS/33LqpMnnNBlf4nvWOuCwZWAQ/wOgMUsOiByiVPw0pV7n/ZsTNHtCQHLp/MU2QgL6JU39vzx1BoBSvtDsfBsY22eQyAaJYgXeHraTlGpLmrDMLsyhPLFsf5+3kjoqilbLeU2y8AIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781714; c=relaxed/simple;
	bh=ny27h0zO3Ndfn/qM++rOff6nZaKGRZlfO0GvhJeJgmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=mIqUp+yCKIxpSXzu0alpytfEglsBdhjjGMIZ4XVkUtuLa7ImmL+UhlQLWEKnd96ANmjY8bvrUFsmSE0++A9uin1HVEuOfcjHUl25W9S8MXWZVKxdQfeHPwsh9Va+vrig6BSKPJu6QNj52OlEXpB8724Rl4ihag5J8jWg+GwGbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUIiAiIG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUIiAiIG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so17330795ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787781711; x=1788386511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6eKz7tR30Dozwm5hWg5ie0MrnymWRTzkxQg3Uw+4uY=;
        b=tUIiAiIG9wakY81AEYKMj8BgwBNa5TU+hmiBzBcHp8Ea2azWzTjNkKCI8l5lUCOVRA
         7fDyVSi7sTqEcXIlExNgdvI+R095j8HY+1Q2Ddz6ypvl2wNru7NexQOFRid/ZY6DatDM
         YaAGRAnMBM3w/j1L35eLaNog517ILlR3FisFmZI5lKKskqga/RskEe3YkmKhi8CUcwQc
         Y4TjDBtwSKAfHZ0qm+ViT3IO2/eqejtBJmVk07jped4xdvtryL7f0rvtbXgFGfVk58JW
         lKI64YcIe6C5TzuH1GNOjxyHQISIJAjcnfjYs8PbNg6IiirVxeJlZ28DS7AXrYZPOf6z
         Yg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781711; x=1788386511;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H6eKz7tR30Dozwm5hWg5ie0MrnymWRTzkxQg3Uw+4uY=;
        b=pj/jGpqArZdsaSQukvCBdk6SRoQtkAPQ98Mf2S11MNXsmItAmW/x206WMrrslX6pPP
         v51Y4F/sS6+K5EoOlQV/ptS3N90iPDtI2VaC67zb1+B2AekZTwTlS60TVU5p9DRLcnWv
         9/fmXeRT6nxFJ+TzIvq+tne3p1eYLi1PmYlm2crINrl43YlRikSYbq+xT8Cw0m8f6nXH
         ypOFvZ/fFKEmPjiMb9EPnBGmL1Cq2FyrjyY4qIrQ90ki/jKM2Rd5rsPQoegrLr3yR062
         VJXJp4FBY+BfwF8joFHdUmEpjiqTpaGC7uT/6zwAPOwKOKxR10ZwbxcmyuAQOyGhkM1b
         HJgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgufqTbW9nN+Mt6XcZUv7YJa1dfWNKXuxLrPUGSD0X/d30TBrLayMmVsP1kYPch41/go4QF7GvivN1BhmN49o=@vger.kernel.org
X-Gm-Message-State: AFuF++lbLmlNoi7lI5rpHnL3mSyymTV6LCmL4ZXtKckbLKoFrKlSf0XG
	jz8TyY2uhKwFdbyti/3OvZa/56bBvgyB4ZAGt5ukEF4Z44OQjpc4uaZY08hxq3bW3Bs4b/8pHek
	q
X-Received: from plbjg12.prod.google.com ([2002:a17:903:26cc:b0:2cc:e407:8fee])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74a:b0:2d2:da8e:9017
 with SMTP id d9443c01a7336-2d707ae31e5mr144405135ad.8.1787781711014; Wed, 26
 Aug 2026 15:01:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 22:00:34 +0000
In-Reply-To: <20260823125155.1136740-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260826220041.4075333-1-morbo@google.com>
Subject: [PATCH v4 1/2] userns: Add __counted_by_ptr attribute to struct uid_gid_map
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bradley Morgan <brads@mainlining.org>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The compiler attribute __counted_by_ptr associates a pointer field of a
struct with a sibling field within the same struct that specifies the
element count of the allocated memory. This enables KASAN and fortified
bounds-checking to detect out-of-bounds accesses to the pointer field at
runtime.

We can add the __counted_by_ptr attribute to the 'forward' and 'reverse'
pointer fields of 'struct uid_gid_map', which are counted by
'nr_extents'. Since 'nr_extents' is defined in a sibling anonymous
struct inside an anonymous union, the nearest common non-anonymous
struct level is 'struct uid_gid_map' itself, which is supported by the
compiler.

However, doing so has runtime implications. In the original
implementation of insert_extent(), elements are written to
map->forward[map->nr_extents] before map->nr_extents is incremented:

	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
		dest =3D &map->extent[map->nr_extents];
	else
		dest =3D &map->forward[map->nr_extents];

	*dest =3D *extent;
	map->nr_extents++;

At the time of writing to 'map->forward[map->nr_extents]',
map->nr_extents is still 5, but we are accessing index 5 (which is the
6th element). Under __counted_by_ptr(nr_extents), the compiler and
KASAN expect the accessed index to be strictly less than
map->nr_extents. Therefore, accessing index 5 when the count is 5
triggers an out-of-bounds panic/trap at runtime.

To resolve this, insert_extent() is refactored to increment
map->nr_extents first, and then use map->nr_extents - 1 as the index:

	map->nr_extents++;
	if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
		dest =3D &map->extent[map->nr_extents - 1];
	else
		dest =3D &map->forward[map->nr_extents - 1];

	*dest =3D *extent;

Assisted-by: Gemini:3.1-pro-preview
Signed-off-by: Bill Wendling <morbo@google.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
v2 - Remove Gerrit tag.
v4 - Added comment explaning the change. Corrected the "Assisted-by" tag.
---
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Anand Moon <linux.amoon@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: codemender-patching+linux@google.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/user_namespace.h |  4 ++--
 kernel/user_namespace.c        | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.=
h
index e38d9e60569f..2962256eddf7 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -29,8 +29,8 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 			u32 nr_extents;
 		};
 		struct {
-			struct uid_gid_extent *forward;
-			struct uid_gid_extent *reverse;
+			struct uid_gid_extent *forward __counted_by_ptr(nr_extents);
+			struct uid_gid_extent *reverse __counted_by_ptr(nr_extents);
 		};
 	};
 };
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 0bed462e9b2a..786dbf0506ca 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -809,13 +809,17 @@ static int insert_extent(struct uid_gid_map *map, str=
uct uid_gid_extent *extent)
 		map->reverse =3D NULL;
 	}
=20
-	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
-		dest =3D &map->extent[map->nr_extents];
+	/*
+	 * nr_extents must be updated before the extent and forward arrays are
+	 * accessed, otherwise KSAN will assert an out-of-bounds error.
+	 */
+	map->nr_extents++;
+	if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
+		dest =3D &map->extent[map->nr_extents - 1];
 	else
-		dest =3D &map->forward[map->nr_extents];
+		dest =3D &map->forward[map->nr_extents - 1];
=20
 	*dest =3D *extent;
-	map->nr_extents++;
 	return 0;
 }
=20
--=20
2.55.0.897.gb25b4bd76c-goog

