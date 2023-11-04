Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764F3C27
	for <linux-hardening@vger.kernel.org>; Sat,  4 Nov 2023 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hDDHeKXn"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764D194
	for <linux-hardening@vger.kernel.org>; Sat,  4 Nov 2023 13:43:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7b3d33663so38435127b3.3
        for <linux-hardening@vger.kernel.org>; Sat, 04 Nov 2023 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699130620; x=1699735420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pM4iIP95/mnmbwbJH/uUs68LV5bT9obYBYBO1xuu04M=;
        b=hDDHeKXnWNXTPAtkuxlGXsxxym+qGrtubohSZt2rBmYUMUmSo1CXQr3aFGsNIh4q0w
         pxlOhHL+cGdIrwHyrcTlF93te5KyMqDY+1duSbMXB2Sd3JbIgy4cxvTWD2ETMoZUAGSM
         pmn0lqBmzdGwhrmwfEvgeTj/FmOYjl7MpZijU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699130620; x=1699735420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM4iIP95/mnmbwbJH/uUs68LV5bT9obYBYBO1xuu04M=;
        b=CzorX2lLJW53Q5TnmwP1gIZp3WmfaF43Eiedv031hoyEssuV3OVDLcVj3shSYZ0UMY
         3cuaI2nEkpAZ84495eNgBLVfHyyUNBur173lSJW2O7xt3Aqr9yIeUzRIUL+rJ6qz615p
         jY6EbKVsO3yoExMHXAazYsNEr7Wf9uq6/ucVlbP6cVxCwFaMg+OijxxYn6N9gMRC+UoY
         CgeWlkSpr1hQOY6aA5y2bRqiP4O6HmLsuzX/OimqPJlvj6tmMGQj/bNpKEUdRT75ku9x
         H3kpejl0TOqZe/YA7ul2QBkVensl0CSP1U7jW8X2kW58j2W8iWx0SSW5brsgzmbqc8Sb
         3T7w==
X-Gm-Message-State: AOJu0Yw6rSjKB+QwAM7P9DVPsoxEhAVoWhbIN1Pu43MTW1OwSt6sLbRk
	2rZNLEJcTk56+1ODEKN1/sUh0g==
X-Google-Smtp-Source: AGHT+IEdSQ3IC0cAAkDzAjuud/+CMTavM6U9ZRus1BZZTmlAQnxxy1XrRq7VXLw5K3thTVWMqJSTHg==
X-Received: by 2002:a81:a04e:0:b0:5a7:b560:12df with SMTP id x75-20020a81a04e000000b005a7b56012dfmr6552277ywg.8.1699130620090;
        Sat, 04 Nov 2023 13:43:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o20-20020a056a001b5400b006be22fde07dsm3242567pfv.106.2023.11.04.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 13:43:39 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: randstruct: Only warn about true flexible arrays
Date: Sat,  4 Nov 2023 13:43:37 -0700
Message-Id: <20231104204334.work.160-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kR5FehWce0r7F/vvyX9p40ys7M/eeh39lUxIbhP7YkA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlRqz5pwxXM77qFtfhXY3OYmVRSzXSB4rwX04oL
 H9wouXg1+SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZUas+QAKCRCJcvTf3G3A
 JsXpEACMG2le8vL4IC9PsGB5+RwrAs2wcJH1p464aujRMT3447jlnsIImB0T+/gn4K0yS71WJE7
 nYamPkioTBVnEN6cKKAaOkWcZjkih/bVV8LA590RyVkoQg9C6a7T7+VcZmLL8kYeV103dhU7xM/
 /mghq9YFYbpvn5oEg0c+Q0TKcd76l9oHmBlJ+ke3aee1QM92H8sleY+60uCAEjnbjODwWhg+rWA
 Hw7XBbdpYBb3wjbxj9zigYenIJ4k/PABrwtRv7TBBKTCVz8lWWcDarSeTgDUOuw8gE0mgg6d6qK
 ZkK4MlxlfBGqVEC1uV9WgWGXKisdM1VYBIM4N0EgmbR7fQHtgFHK+nNtYnLb1JNVfDvRZkVS7wN
 coYiTrfMeRMtsQ7P/JUhO/hq4cokTTNoI9tNoSWzJVkko1ErHYyvdoTNar3HFR8reKYPa7Oarop
 kuf6q3v/WucHZKIvvvgXdPJozhtKtDYBvDFvrLn5+2zIcNPv6oAGu38GxV6Lz6l1FTSb/Lya2IN
 a4F3LUehs4kq2ZjLqA/Fmyz1rE/AxkoKXmJ+GJ8mjd+eXooAbaa5tUIZx6KnKsqkfrw3N54vy7e
 /BbEMV5HG1JaI2Y64ed5IbAxSGlfDHoDlC+o+cxroVztVzWinZkVTcBzl95twub6yAhlKZV8QSz
 89FX5+f HS57NFbQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The randstruct GCC plugin tried to discover "fake" flexible arrays
to issue warnings about them in randomized structs. In the future
LSM overhead reduction series, it would be legal to have a randomized
struct with a 1-element array, and this should _not_ be treated as a
flexible array, especially since commit df8fc4e934c1 ("kbuild: Enable
-fstrict-flex-arrays=3"). Disable the 0-sized and 1-element array
discovery logic in the plugin, but keep the "true" flexible array check.

Cc: KP Singh <kpsingh@kernel.org>
Cc: linux-hardening@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311021532.iBwuZUZ0-lkp@intel.com/
Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 366395cab490..910bd21d08f4 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -278,8 +278,6 @@ static bool is_flexible_array(const_tree field)
 {
 	const_tree fieldtype;
 	const_tree typesize;
-	const_tree elemtype;
-	const_tree elemsize;
 
 	fieldtype = TREE_TYPE(field);
 	typesize = TYPE_SIZE(fieldtype);
@@ -287,20 +285,12 @@ static bool is_flexible_array(const_tree field)
 	if (TREE_CODE(fieldtype) != ARRAY_TYPE)
 		return false;
 
-	elemtype = TREE_TYPE(fieldtype);
-	elemsize = TYPE_SIZE(elemtype);
-
 	/* size of type is represented in bits */
 
 	if (typesize == NULL_TREE && TYPE_DOMAIN(fieldtype) != NULL_TREE &&
 	    TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) == NULL_TREE)
 		return true;
 
-	if (typesize != NULL_TREE &&
-	    (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
-	     tree_to_uhwi(typesize) == tree_to_uhwi(elemsize))))
-		return true;
-
 	return false;
 }
 
-- 
2.34.1

