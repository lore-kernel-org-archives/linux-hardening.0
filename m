Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B7111BD
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 03:42:28 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8629D618B
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5cd27b1acso91437065ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695786147; x=1696390947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGJfI+lZ4iSfQ93mihAmCKetWCxWqPDzFkg6Q6FWgBc=;
        b=Bs7xjUEuS8NkFPZHJGDJ2TEI8MNHM5Tz6S/mOzXHCqJoYeG8s73+rqFxehM6W9d0Kt
         wgxsaFDT4RoUKAw+CU0VmHrZgfzI1vpBz7Y07O6WES0bdXkIyYu2DrOxTBJ5JixFquGM
         J/7Qe5i1yvKNnVZ0c/UHwkPScoP7L+UScfV04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786147; x=1696390947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGJfI+lZ4iSfQ93mihAmCKetWCxWqPDzFkg6Q6FWgBc=;
        b=h2MdkyUPmzwt9bsSVIi5gNemcTepq7x9X/mvnxb73T0Y/5uHPBvA/a3LRPsqiYyx43
         HQZn7EG3vOooejqznCN2Tl+i3nbiFQ0zCZMwZBWPiSmoAhnxwOzLujko7nlqBeTj3IGL
         3Fzehi2MXw8xKusVzAaPtByMr0aQrs2dwdNhl/mO2vCNChcoG+jS9Q52pej7GNtUUW2J
         u3nR4qvql9wGhc+TBEXS53+Ap8mAbxsomuq4lFod1KaEFmQG09jYN/9az7Xn1Ara03gV
         HAfMhm010A0ymdkOpU34Z44rlI2ci/px3iO3nwdKfKoJYcMn+rEi3m2Dy9ZiMKWTnA5I
         a1Cg==
X-Gm-Message-State: AOJu0YxyNvE42lFOJgfuteZWEPSzv7ENlvEEPGf2LTsEbSfpsVH3Q2H3
	UvDZ2eoYpcwSkp4/wzD+CRG26w==
X-Google-Smtp-Source: AGHT+IG3vmw0qL9sWfrthHzlDQju/5u8n9c1TNnVsBUEHwDjOoLhNFzP4dPTCN3Xs5EKe3Hg9ILQZw==
X-Received: by 2002:a17:902:c94f:b0:1bb:598a:14e5 with SMTP id i15-20020a170902c94f00b001bb598a14e5mr992121pla.43.1695786146709;
        Tue, 26 Sep 2023 20:42:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001bdc6ca748esm11918838plb.185.2023.09.26.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Sebastian Ott <sebott@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/4] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date: Tue, 26 Sep 2023 20:42:17 -0700
Message-Id: <20230927033634.make.602-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=keescook@chromium.org;
 h=from:subject:message-id; bh=lOC6dIm6BOZ5YdJlYfTe2LeekCnJ++QGcs0vKnnP4ps=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlE6ScQrYRvW7/cLoTymNp+QzCK4E5+g2pQV1h7
 2TULnPSJZmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZROknAAKCRCJcvTf3G3A
 JoDCEACiqN/qgoJ0Ne6hePry6JkdekxC2ghpkyg+pmI99pumwTcgld+j67+ZMdlJ1uoiL+ZLTZW
 kpZQc19iF4kz/hS2BzF5fc3o9zbbnksf5M41zq8EHUWlTko2ebswjaLUUI/dADhqmcfsFOxdlYK
 a9Wn4Yo+Jsryxk8lZr8iC1UsqxoN2OD1JZ/IScy8PRDGyoj5SW/8KXm4YVbT+dUCx5rv/HJ+qzk
 n6mLTE09gnExRim0Wkug8xsfhXdnRLf3JEwhHm1uYDvLhIVG4jp9a/C/HyB52YRBBD0pM7HD93r
 eDzoVjwiGJLGETpwCEoKdJaiNrkBYYwZ4uS/OTgkBkxm/y/MykXwxzIH2FQRU6ex9YHjbc68Re4
 abj6Ut8m5K8OBP497GvZJeM6fR4y1bL3UtMBqHGNipTauOPZtp14wuE26++n4jCcIdnbdo9FmYz
 GXg3/jNe4JkK4sHhwUXSCm07Gn3QavzFisWXca4G/AqBjF5k4hwBnYd8jg6ObkJgzPZgIHuZ+CN
 AiMdCAMOGj2d0N/Jlti27JIkfB5ifjxiV+OXygf99lkJgwVe18U6L6cPvdtxbYOW3xWLKUwxgqL
 mpHIt8n/rKLRvretb5VXJySNBh2q2kAngczfkZzyHdbxaj6wAKLbZiiVdt+WDa7CcxMhvKi9oot
 B6BlPROL CGrPl5w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This is the continuation of the work Eric started for handling
"p_memsz > p_filesz" in arbitrary segments (rather than just the last,
BSS, segment). I've added the suggested changes:

 - drop unused "elf_bss" variable
 - report padzero() errors when PROT_WRITE is present
 - refactor load_elf_interp() to use elf_load()

This passes my quick smoke tests, but I'm still trying to construct some
more complete tests...

-Kees

Eric W. Biederman (1):
  binfmt_elf: Support segments with 0 filesz and misaligned starts

Kees Cook (3):
  binfmt_elf: elf_bss no longer used by load_elf_binary()
  binfmt_elf: Provide prot bits as context for padzero() errors
  binfmt_elf: Use elf_load() for interpreter

 fs/binfmt_elf.c | 192 ++++++++++++++++++------------------------------
 1 file changed, 71 insertions(+), 121 deletions(-)

-- 
2.34.1

