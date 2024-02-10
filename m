Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0A2119
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527810; cv=none; b=fZX8s54JdmSd/TPq/nogkyqajTX4xW8DyHbbMM61zVsd9qxa0rY2vk4oN0zkUE2CrIvApF1MWmdahQlaiO3e2HXB3pT0KJUO2Yod5wE4i2SO591IlGf5tggOgCtXoF9BZFt589B7fngakggX/6oEZBG/Dpf29l78zHSuFcEiAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527810; c=relaxed/simple;
	bh=UIYu98yTnq6IoG7p77xS2jBpkcg5lQjLVhPitCGvuaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/DwDz7i20e8MG0GdRWZPGvei+dWFh4noipFKu3RTIELSF9ZmkapWN+h4maFq5aKmmo1m0nzhuXLKAQL1TyHRimpSeTuuuip4roEu93fqos81632VN/xLTdihfuMxzIHa0KzunpirqMZqwyGulHy4s8clQ9qoHW7QOfxMTTxFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aV2T8cIw; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aV2T8cIw"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so1016588b6e.3
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 17:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707527807; x=1708132607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ze5Pa4NcSME/+yvLBfrb6tRG6ghxrx7Dfdjk9njymg=;
        b=aV2T8cIw3DOHGt4SuipZaxVPBB2seJ/i0KZIvbBECJd65MJauEM4Wb6FpyKljfseA9
         HCOvNcmK72i6wwzzXXPhomTaNZRPaUicWtC9OPKI7LgsI91KjMdgUj2oxaPAJTz4nimG
         zScCKp5nSrQM0ypNQqE3s3fHGPYRaGlA9n5JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527807; x=1708132607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ze5Pa4NcSME/+yvLBfrb6tRG6ghxrx7Dfdjk9njymg=;
        b=nhbmo06nRgeWdqPXcSG4h1ZfdEjBjXTyRbNahUEE/yKqDgCK5xh4i/TAUzFZmB8eaR
         8xKYz4JJtFdSl8Gw58e+66ha5kQBEW0PN0cudPDvvaqddCA1XgbJKT/81x6aiRGkLGoN
         89w9hte3Fl2HbUjAu5mubSagX1rb/nmS4K2NCCaz2hulhhP86b6+9+fSNDvkbp0XQY5c
         zk1IyE/WmTZMQq8Icpps35qkZI5CFeVcTdwDUP6vTUzm8PTN47oTvT7xadmOpQKPBNIu
         gmJZlqFvmEHZQ56F/jT6hU+PB9YOPTGjphSjrZfoMh3hwFvCPGPxhcNDZ+KXakINJvjx
         Uk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhKzO1IydDrwvLjtzLlSzyEloZJJr97ouPM1qDQkNy1IMYNKXeQDKYHj8h4Fhe4Lre/lPASLRl0Q+a1f6u+/z3SOliBmPi1T+qHzMeA4L1
X-Gm-Message-State: AOJu0Ywg6YWP2joSNZUKI9p4RmvNOhIjXy5TdOFM1fXgZLHS97ZBmpBz
	bt3KFL9+cgKgimUt24dstoUqpjuzkSyl8dQxg9VtClevChSu2DxlfWjmxk2zCQ==
X-Google-Smtp-Source: AGHT+IEKi1eEOSwMW3MpZVRb38CcWUA4s3Gb7uYAM3HsK8HkoIO5prwyulds2tpc/QtITjI/gewPkQ==
X-Received: by 2002:a05:6870:d154:b0:214:9ce3:ed2b with SMTP id f20-20020a056870d15400b002149ce3ed2bmr1021019oac.41.1707527807338;
        Fri, 09 Feb 2024 17:16:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy4hT6eVAzCHi32RCAeGUPnPW+nKJJ0FdWDQrrS0gzAB2CjD4XRvA2K6HnrTr4Pm5MQobuWSZNUTYa5ctaVh1oTw1PM8AXx5LHIAfQPN/HPzGsaZ3IytuOcvgT1C4nvRSCKm/OpSVT2YDde0/ct330RoSbt+xSIzvjF8AaLebL+BAemdVaIyMvDcmcz9bQHAuM8pfUEjt5mowTf7fOwu/nx1RP0Wunjy8O1hJd097SyPY1PLza1V5Kas+RKYUDioe/bursi4YllNtvUS32G/8KYQF+4u7qhFT/61ZxUFB7mrKOFZsA6DkScUkrPWbC65b2dNMRPX1o0qBo24NmJzSvMqkd2lMeWEW0GPPzrN5Ma97cNijVsRIhpqB4XXyRb7hJX1Au8t0YuntshA7Mny1e6PLPfe9zvE6lTqInPviahXWQEh3A4dPw4jJ6I7oqITkZb9RDth0VyqGkJJU1EvrbHMUSBSLenk7bbbiwAsGvoOty6YH0FkLwjXmUxCiV
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c125-20020a633583000000b005dc4da2121fsm2481005pga.6.2024.02.09.17.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:16:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] stddef: Allow attributes to be used when creating flex arrays
Date: Fri,  9 Feb 2024 17:16:41 -0800
Message-Id: <20240210011643.1706285-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210011452.work.985-kees@kernel.org>
References: <20240210011452.work.985-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916; i=keescook@chromium.org;
 h=from:subject; bh=UIYu98yTnq6IoG7p77xS2jBpkcg5lQjLVhPitCGvuaQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlxs565KmSp3fQbXTcJwGQKFvGMK3wEqdmQ7/xb
 uTx0bjHKlCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcbOegAKCRCJcvTf3G3A
 JhaYD/9JDBbI/XgOae54dbshjDoJ76Ha6DpLzDux/EAHjpeJ1+scXgSkqee2gAfC/wb9DvS1fgS
 0deWCT0upE1Hv3YKcPr6aUv6nqbRTffqCDL1aX/TPdqBPNA1LSXPQFJj9fQJ8qtaJy90yivafd/
 /luFZAr+qRIcKjRq2CJRmrknxXSIJD4kmI37X+9U2bG74t+XQuTOHeH4m47l5xMorFT5Njg+Emt
 Zr/Ls/vfK9KojTi7tirVLSLtHdJruvQtc3TXRAzsnv/UTeimSYzBlwxTN2dTeuCfjXdWe1MrncV
 UrAzhMcRtsUub7GAE3awCB8nX6FQaH1q8DCHrv3vpzVuboHBzOsSmYUbvO/9gMSr3rXqYO2FCR6
 GtG+OP9DfWZmf8zCVLcWDsHy0qv5mUAXL5TUMyxR4REILeuHI65nhyxnGFZy+aC3zq35A/qJ7bm
 EcZPQy4GbvlKuvgEAIksnBOIJryiQkxWj/PvZAyIjPMEC6ttj2QRccFx6XhcOgHxtumDESQShik
 lJ1dk3K+ru9HaA2RDQ5ikQpn4IDFiItrGzuT4Z5NigIdlRcbdWKiTjt7+v2quTN9ZzQYQ+hA8pU
 t+0mGm+YTF7UOD23q10V/9LCAuGlhP1T7WMFc1/3H+Xui4Ljpd0BZV0i4jpfAEh7XreSEDWl1ep 5z3ELwYLKxghsYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With the coming support for the __counted_by struct member attribute, we
will need a way to add such annotations to the places where
DECLARE_FLEX_ARRAY() is used. Introduce DECLARE_FLEX_ARRAY_ATTR() which
takes a third argument: the attributes to apply to the flexible array.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Keith Packard <keithp@keithp.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h      | 16 ++++++++++++++--
 include/uapi/linux/stddef.h | 25 +++++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 929d67710cc5..eb51f6727ecf 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -81,8 +81,20 @@ enum {
 	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
 
 /**
- * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ * DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ * @ATTRS: The list of member attributes to apply
  *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS) \
+	__DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)
+
+/**
+ * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
  * @TYPE: The type of each flexible array element
  * @NAME: The name of the flexible array member
  *
@@ -91,6 +103,6 @@ enum {
  * named member, but that member can be empty.
  */
 #define DECLARE_FLEX_ARRAY(TYPE, NAME) \
-	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+	DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, /* no attributes */)
 
 #endif
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 2ec6f35cda32..5499c08ad011 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -31,24 +31,37 @@
 
 #ifdef __cplusplus
 /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
-#define __DECLARE_FLEX_ARRAY(T, member)	\
-	T member[0]
+#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
+	TYPE NAME[0] ATTRS
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)		\
+	__DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, /* no attributes */)
 #else
 /**
- * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
- *
+ * __DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
  * @TYPE: The type of each flexible array element
  * @NAME: The name of the flexible array member
+ * @ATTRS: The list of member attributes to apply
  *
  * In order to have a flexible array member in a union or alone in a
  * struct, it needs to be wrapped in an anonymous struct with at least 1
  * named member, but that member can be empty.
  */
-#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
 	struct { \
 		struct { } __empty_ ## NAME; \
-		TYPE NAME[]; \
+		TYPE NAME[] ATTRS; \
 	}
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	__DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, /* no attributes */)
 #endif
 
 #ifndef __counted_by
-- 
2.34.1

