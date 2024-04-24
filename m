Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CB16190B
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976050; cv=none; b=CriPcVNb3gEX2tDqeY93Zk4UXGWsNSyIlC8Tb0+ICRQl98bIwCvGGCsrTivsag/sL09gqO4oS8+0oNxoWkFYT8eXB49BxUVjDOmgafHuZMz0xhYMW8NYkAtuqD1t8ymX4xlOP/JQVbQPnSC4HKPFDVRyLlT3b+sx0uhv9d+Bpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976050; c=relaxed/simple;
	bh=RUQFXdH8cHsUkS7WjlnySjXvh+xuWtYB5a0k0jg62aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plylf3GTz2Ua81EVGJXXEXuqPON63/gGyjI9zPgRrfdUqJHywmuUWpIip5i56zB5O/f8VGQY0Bb6kQ2ArR5wAfQhFARJMW8hrHfzvZAavig+ORvgOXNZhYnX81m7xcn3e9ZypOJe+L2O5KxNwZQADJ7UnBnrFcgY4agPzHAdJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kC/ysrQz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kC/ysrQz"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so78404b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713976049; x=1714580849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqVdIKh+FGhuAkF80diaGZNWgnSMw4HuAlHZ0aOXJaQ=;
        b=kC/ysrQzeC2HWDplE6JwbcbitP74A7X7oc62Xp1KOvuEBZO/Uwi+99DPeodb85PPe4
         7ohxcItNZy/clQPJqPyuvQjt5uV/M4kKAXjIS7s1Vhwf7SG/mhARqHE8q//p3NST6U0Z
         4bPHiF3gXHkpohHvsZJbbWJm+7lC5uhrWM76s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976049; x=1714580849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqVdIKh+FGhuAkF80diaGZNWgnSMw4HuAlHZ0aOXJaQ=;
        b=TgMf0xSY6KGf0deS75D+NDxNWg4ApjnUbEAbslgpg7CkLHNlugFjXYoWRVrQoIMf87
         JSQF7IlS28sPEnLliuzjN4lC6lkJiRGBv9xJI9dzbwq89Ij271bqFS++KU60wWrvFlnA
         UYPw19s0BFNCl8MdLWe5dv7nOSFjXtXqyAT9hx6OPwJ9vXafEA26pUO46FzBnUfvsE3A
         APBHuYjuDYm0DpWvQojj5cqWvJ8IcuSGYvoxOvAHWSkUUn4BLJOgF9/QWnHeJADjPush
         1iSNlZY6VYvCoEvVqRC/2x9lo/wBv6QNJCjBIIuJaevZ261GUiVJ5EVBHiMmkrrbPIQl
         bHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUknH78LG5A6cviBkXOwMnzCGdShs+aTPolB9fQ0YXbbUTJ9Rpe2KtnEF3Nocdo3CASbqT/TKy3YNpgRJdbfuyK1LwwBA8AijhigmSce5hr
X-Gm-Message-State: AOJu0YwDdIzeRenLjrmOnY6BSNQT7kCLElyfiSSn4RggIApS8bgYEKBc
	rkV/14F9W1fDSAPtGuAD/MbuQJJtiM5uuoob628lSP9On7BONMTsPte7zFlXPg==
X-Google-Smtp-Source: AGHT+IFKjIGKbQ918qemrQZuactvTy19Wo4N7YX9x+pAnt65I+/kRKl3YikmICPFbANqjjaaSMR3ew==
X-Received: by 2002:a05:6a20:96c3:b0:1aa:59ff:5902 with SMTP id hq3-20020a056a2096c300b001aa59ff5902mr2898404pzc.9.1713976048655;
        Wed, 24 Apr 2024 09:27:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bq15-20020a056a02044f00b005f806498270sm7830151pgb.9.2024.04.24.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:27:27 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add ubsan.h to the UBSAN section
Date: Wed, 24 Apr 2024 09:27:25 -0700
Message-Id: <20240424162722.work.576-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=keescook@chromium.org;
 h=from:subject:message-id; bh=RUQFXdH8cHsUkS7WjlnySjXvh+xuWtYB5a0k0jg62aQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKTLtBpO5sGKQbNTQQhxZ0ZsYqUs12l6Ughw85
 8Dyfzf7pCWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiky7QAKCRCJcvTf3G3A
 JoKXD/4pxNwOoTftHBpfo2Stn6qEj5ph8TjzUq5xw0sAvUVgJmxp7K702EyccN/XySiLP+3ZEmm
 9RutTYSsj8CcQBjVrhOLb/xvlrEJaIspTh2p9EHB8piS8HHt6lpQE4YxgkeBiy7tas5vedCTzXa
 1a+mb8j5zAyqx3nIcOVe+QbaQuQob4txxHUJZ/OFqTgCnpZQdi9IFSR2k5ILVhYuoBqyF01ESCI
 1Osrm+i3pe257pYqItAU7opFf1pPETUEUoK/yCZ8oriu7XtP5WSovuV/aBZiCxemqQdqq6FmCOJ
 Yirj9oYJvuhXNEfkyi1N9RNTYWAyAfNuULtzx8BHLDMjtX4AKL31AYH4O/2DqoFb/3y1BWZyKBd
 cppLw0sEN52uyp84/RCvPiapZ7/M5JZbRbdoS7LKI0WQ9DdZsUVB0XJ8t9ckg3gaIGCbyRJmsQ2
 d7krynFko65NOjKREmXj2tWd9ajjgJAY6ASIurcHDqVhUjdbfcCSYjheAlDGbljc3pzaUPWvMdZ
 Iwyt3rCA32x51eV2YP4S7q9XgtONVibEmpI+uCnxfi/c6iReQpCHB2XmiLbIDLdkNo3TDyS0YA9
 S56kXblKN0pe2kQ7dvOsEd/FZzu6Nfn9CChe27WtPhDE6e1v9tVB/qxQOCIx6tHLFHvAYKafkbH
 mZ80ao2M K1vthAg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The "ubsan.h" file was missed in the creation of the UBSAN section. Add
it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..5acac5887889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22653,6 +22653,7 @@ F:	include/linux/ubsan.h
 F:	lib/Kconfig.ubsan
 F:	lib/test_ubsan.c
 F:	lib/ubsan.c
+F:	lib/ubsan.h
 F:	scripts/Makefile.ubsan
 K:	\bARCH_HAS_UBSAN\b
 
-- 
2.34.1

