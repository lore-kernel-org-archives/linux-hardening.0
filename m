Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873F38C
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZUzDWeul"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFCE11D
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 17:46:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1caad0bcc95so7480025ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697676382; x=1698281182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tXAb29sjCt8T75Ku0bEzzHDnXK1x1j0sz59G7gCxdJM=;
        b=ZUzDWeulhhj4JojPItBuAy4klcnmUbziGvw0u9WYj2CE0R+uX29lnW/wSihuvFtW/T
         yFyBCb291+ahAWb9IKqlK1n1jg3PMAoLRH5SJVc2itw3T346dS8MsQA3byvVetbOgzET
         Ew3lA8O6gDkf4pTvRCYijPlJ2dvqCspnDTUMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697676382; x=1698281182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXAb29sjCt8T75Ku0bEzzHDnXK1x1j0sz59G7gCxdJM=;
        b=FS2vVz+m92YGBoUokiN/Nw7FC0tRzEn0rRRJkWLiIsHF3xlta8M70THZve9JVm4LN+
         uD2k+ot2g1Z6/AnnBZ4BRa5TuZfv47aS2jlMAujHvQz4g7v4DpiATvHuD0xYve0fsINh
         0zLQ9kS031AHmBpSUpogtrTXUY9jFATsh1ZzocmwYv4HoZbdjgQPx3bCosymH2x9UyuV
         ePB+tBCTud9J/E0Q1fIqgE5pU624CgFfj/QpXckmFYg/WJFsMO5CoQGdtlvLmyvsZNkJ
         KNJpWmpjkJjoWvMlSOeZBkpF3NGyd15WOgGPobH6DfUGGkRZOcFFT2+0I0ViNjsWfClg
         Nbxg==
X-Gm-Message-State: AOJu0YzFYP7l03/f+zkHai1srYmtwwAs7lnuuoOxRLA6Lhjn5EUhWEcr
	X+/kyL6Ih9NVmihaqGkcJ0dKeQ==
X-Google-Smtp-Source: AGHT+IEFHT6QQUfJOhvPe0xOocNN6BM/HGAPTL5nIlptsCOCpabqmAGQDg7/A9rEP66ipR+kY90/Cw==
X-Received: by 2002:a17:902:c409:b0:1c9:dff6:58f2 with SMTP id k9-20020a170902c40900b001c9dff658f2mr1011506plk.59.1697676382628;
        Wed, 18 Oct 2023 17:46:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001bc2831e1a8sm548141plb.80.2023.10.18.17.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:46:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Include stackleak paths in hardening entry
Date: Wed, 18 Oct 2023 17:46:20 -0700
Message-Id: <20231019004616.work.960-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=keescook@chromium.org;
 h=from:subject:message-id; bh=OH27hzBWmrh/4B/6lQnJmmp0xT7GhP0If/InC5APbmM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlMHxcqTrPYv51y9kX9dUxGBlFs3tf1q+9EwAol
 aXU9h6MMDOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTB8XAAKCRCJcvTf3G3A
 JnDhD/9MZHL2eU0fW/D/ONnjQQdgcNoq0+gPT0ZdCm/L0QDVr8u2BjDtqrv74FJ6oLBt1qwYec8
 lALFFa7cz0u9lIEYgs0H+mMYAArUj2XG/uo+Bv2SI6wgPZJFxZpHRc6KTlx8QIUfaM1XX7KALuy
 XxYuf9C70bSCKz/gfOCYV4aJyGFZ0SprAEHKSUoEpabeOo9baREq3qd2b8P3n0fwaRh/fJrumoP
 loCeTWQMTLqGj0KWzM3CO5nHe9aZAP42tbXxNm3ebjJtC7RITRj+CIXYC43QXZuVpCNl/vxWsE0
 o5iujwSycMkB2s5orGHO9S7l2/pYvy83LhTJMvl/b5+84HlVf09p/nCFFsrvNoim3qqcidbxHTZ
 GE78xaK9o7vfg5B3wJv3nA92KBSCTzFCjTO3BlkrNH/f2ZwqoE1ye+UF8g5tHevHFmEWU4BP1g2
 sTX7fmCptqAfqYqYMuLLbwU0vJ4dwpQhO/m0Yu5Bq20NFJ2TS1ALxkHsRZO98oOXt24rnleZVGB
 HqQBtiG2EeUssIYIkKinxakfbxh53yexxIJtBpfNTQXAgJvFEHfgijRrXsoOlAdRvHWyAa4nJlV
 444qeMOb/hQ/RmPkp1reUtAOeroVeO64SX+u59JYSFHw2KxYTcwpo1cGR2OKLSg2jVhdQ2vWps4
 LXYht8xO rM9FhZQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While most of the gcc-plugins are self-contained in the
scripts/gcc-plugins directory, stackleak actually has some additional
files. Add those so changes are directed to the hardening list.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f18ed0fbd42..a4de29c0036f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8615,6 +8615,8 @@ L:	linux-hardening@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/kbuild/gcc-plugins.rst
+F:	include/linux/stackleak.h
+F:	kernel/stackleak.c
 F:	scripts/Makefile.gcc-plugins
 F:	scripts/gcc-plugins/
 
-- 
2.34.1

