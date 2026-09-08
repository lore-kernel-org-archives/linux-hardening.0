Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F287480321
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906462; cv=none; b=QAysA5nMetgFMaJR1FLbaadoRUKXA9/kW35de2xZppt79SdlZE7I3MrTs6DGtNuUH1Mev8KtFXCsCfwKwLCFId53vzLEqLMpVWqYYZO+Gl6vP3HN66GIoskw2wLmzphGqWrKjBK7u4p70KNPShMEtJ+3Z/ktQRPTCvc+h7A9a9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906462; c=relaxed/simple;
	bh=8r91DRLCl/neE76PnDap4Tdsu/lX3HlhEhY6Vwc0CPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PPVmxGDEEZI71NqEgvb/HQCpWpCyISPumAhmUQDxfLYMjpK462GjE7GZM0W7KadvIZ4QFhvnGBdYK1nppT3gJxjhzl4sEQh1J8WhrnIQKUTO20391YBcCUbMsI3YbUICJscybCVyytDiiGVNo1GzV/WJWOiTAn2n1Y8cbSnUqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNR4HoeI; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNR4HoeI"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so7777716a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 08 Sep 2026 15:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788906458; x=1789511258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c9A4iOcSwhHC2tZf3bYzb73lIZurNnt/3XzYiilrGz0=;
        b=JNR4HoeIHEx51/5Ho15WyHZUeFp6yBxjRhKD/XJ1pf8rCocc/1x92knEiCxF9T3VGv
         GejNuwqCX87UeI8lO3QHo6aVwibspOV86Bt561FitWkG4YAYgqmXKjw8BqiBmED/dDBI
         AcqeQiM7+JTF9egfpCMdfOaoe8Y2LC8RWe4OKSkOD52VahOW/QH1ah0fE65dDuHPOko3
         ZBQ4Zx2/BvZAmzsc+MbRSnFWq4UBJRiuajIXKAJQmzQ7WfTvvBJVjCZRAYXBof7CgtdM
         s+wRauoV/Vx9Vkcs62u9BkOP7ySoQLZ584yxH6lMAocQ6E4ov9F6bpXOs/aEw3POkvJY
         t42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906458; x=1789511258;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9A4iOcSwhHC2tZf3bYzb73lIZurNnt/3XzYiilrGz0=;
        b=QpE0ubvr7VvbIRRcYbfVpUDiKU4w/eZgrinKruczx1e/x0XF+oWfdcRi7Lced/k5gS
         Hz9wQyddUh1pYOr3DjhKHbGdWOjH5KSjnOHbM3sOMk5wuBOZd5h6rOwGAnAD2GE3j5Za
         OdiMi6yJyDMX/BhUjem/lqrzURnGeOFt36vcdX4cgtQWZiDmAGM80wUVrAMs6e3PU5NW
         kbBOQmU7sCjdvBO89yzrWasrNu+WOAUXoul3F1k/EMnG/NybRgNw+stOPWPR1ri0bW6n
         y2r0pO7NMK5wLAuGByMF/ibYKeJMmnhivWWFQnFdGYJUNSn4jtlzF3nKOWWlG+kQFnjJ
         ERGw==
X-Forwarded-Encrypted: i=1; AKwUvBz9Nnzdid7K0JxbxU6FJPnBnKyNZ3cQYYqL/nVMFM63lB+szDgxYxE4j7Se7edVTP9CQ3Y+Wv++ns8KgLFLfQw=@vger.kernel.org
X-Gm-Message-State: AFuF++kErmGrHzCvw3fFWFyZO/mX26cHSCijPWWC7Z03+TvGlp0lWgyL
	Q9UwI0taFg9/05v89rE6pBQmn0aNvVssuktkQw3v1Sp8roGcqNxXg+dw8QzhKBcM095+1KpZ+JC
	S
X-Received: from pjbez18.prod.google.com ([2002:a17:90a:e152:b0:39b:9a3e:dd74])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcb:b0:381:a766:efcb
 with SMTP id 98e67ed59e1d1-39b26100e5dmr44973727a91.4.1788906458271; Tue, 08
 Sep 2026 15:27:38 -0700 (PDT)
Date: Tue,  8 Sep 2026 22:27:29 +0000
In-Reply-To: <20260823125155.1136740-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-3-morbo@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908222734.3048684-1-morbo@google.com>
Subject: [PATCH v5 1/2] userns: Add __counted_by_ptr attribute to struct uid_gid_map
From: Bill Wendling <morbo@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Bill Wendling <morbo@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bradley Morgan <brads@mainlining.org>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
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
v4 - Correct the "Assisted-by" tag.
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
2.55.0.979.g7e5102b832-goog

