Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3EA3101A6
	for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489520; cv=none; b=EFVVe/ASZvUrcQGoKLt2xJLPbB0V/P6TQTtaxsARUYekPmh64vd3qwN2KbGRPdemlPnfdSIPv26rkYhrWfZfLldcWiLrQRZphVk9FDhEN5mV9peKoy+aVdRSjK6ZuM9ciCzeqlZu+JzoiFQ6cOJAxPe5XfCMRTVBeuD47D5KfJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489520; c=relaxed/simple;
	bh=y+LROC8XAKNEDoBV1EUp6SDpaGTfmrTNBsAQC7v6vwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tXL7c9Jksvy3Z5WKf2WmGA93UWpu/JQhT1+nrITQDTfjOZlBMLKu7gCF3pFP1h8ZIGbK5EmtKXpawU++PKvZdE4jLsDp3JB32nR2KS+dIaFTSY/pwnQJxOZjoBDJe8Am2C1GfIXc3baYxcxiP03x3r8LO5onLvqfXMzBw1X4ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHCvBCaJ; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHCvBCaJ"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso3434393a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787489519; x=1788094319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8/j626qUUUtpjEjXH+/BZQ1LG4AVUMqvjzdNkuJ+fuo=;
        b=JHCvBCaJDD0fKSRAg9LWzdLJamFDsS9wGc+SRBSi77yHZKfIpU/YlRRzvsBkHs+oXe
         6+Btshki+edlO2G7lZWRvP1c+wzodqq6iG14KyNpCYJsCUO4fEhCN6f9wbGcyIb+233E
         0yqzqtvohArUwjHIp7BSITKAryjqKDJvug4sLXznf1AUQhlBlLYeVK3Iq9t+Nf3w+518
         NGY4f93ed/JGtrtNEIes2ZXXAohW7Ce20klmGpfZ4ReXv1Y1NSnN6znM0NUP/KX3IWhy
         sh+NxgjCrsYzln7t2DVDFcSsbwAqmn9g//GpEI3m7L8NnY2ATW778YQyiPxHq8mDGEv2
         jUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787489519; x=1788094319;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/j626qUUUtpjEjXH+/BZQ1LG4AVUMqvjzdNkuJ+fuo=;
        b=Fv5rpiwEtEdHXTHfZoItj2NWtrI2QX0ojmeGnZ36IBoR2VCB+xP0puIzuz6X3/2DpN
         qMCMi5pV1ZhebMJrhHjMyjwIhoNpeK8k5fTMBRuosWl5lnZ1oiMQd+X7RbSQ/lNKX0zs
         XK/99QmB48tSEs7lToAFWLcLKL/+kCQscUkaEADb4ynK/I49u84uB8L1XlrlgoB331t6
         bBIcMUhPyFHzC9z7UMWID+DPShtzAq9MDnBqKoHYCgc3sa4PJtGojbcmWaoDHL08nfM2
         HBJRpDylGWvCuAfqPCiyAhMgf5HeVWuYbWVQrCX94Apl3hjg5Wn9aXdgFx4Z467G/0bW
         JtOw==
X-Forwarded-Encrypted: i=1; AHgh+Rpg/4oxW5gU/ciX9YBkGh+DfR1iNvgQEsHvRuctSDvDfOlJsCnMGm30N8yR40uLc5SYS9P9Y+wnmOLv/koYVWg=@vger.kernel.org
X-Gm-Message-State: AFuF++nXEGbZRg1tnhNJWznM9yuI8E/0Ew/PewKAcChffMfELT2dLkKw
	UIzCJ0uBNEeGHHc94M49xcWncLe+F7aTjQVYMgC3YWk5jeAxlIvkHO6XK9ScqITtRkKiLg9FM7D
	4
X-Received: from plhw14.prod.google.com ([2002:a17:903:2f4e:b0:2c9:b703:3bfb])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b07:b0:2d0:cc92:f7a9
 with SMTP id d9443c01a7336-2d64add1daamr358614285ad.4.1787489518421; Sun, 23
 Aug 2026 05:51:58 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:51:47 +0000
In-Reply-To: <20260823125155.1136740-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260823125155.1136740-2-morbo@google.com>
Subject: [PATCH 1/2] userns: Add __counted_by_ptr attribute to struct uid_gid_map
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-hardening@vger.kernel.org
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

Assisted-by: Gemini Next
Signed-off-by: Bill Wendling <morbo@google.com>
---
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
 include/linux/user_namespace.h | 4 ++--
 kernel/user_namespace.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index 0bed462e9b2a..7e5371d8f515 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -809,13 +809,13 @@ static int insert_extent(struct uid_gid_map *map, str=
uct uid_gid_extent *extent)
 		map->reverse =3D NULL;
 	}
=20
-	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
-		dest =3D &map->extent[map->nr_extents];
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
2.55.0.860.g4b6b3295ed-goog

