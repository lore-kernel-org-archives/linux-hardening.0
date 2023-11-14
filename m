Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BD2C19E
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VpcK59r5"
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCA10F
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 09:41:30 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce2de8da87so3623072a34.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699983689; x=1700588489; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLGvE6w2nI/I1UWxr+lpIoR/ViMo1XgqtZtp21yYr4U=;
        b=VpcK59r5CrZ3QCH78240cjVtgXDGWCQH7bfIykn5Iviwllo8QJxqY4dQf3VOgGB51O
         RL6mlFZCTDmoMUwTw/GAbrsx5i3FgDMP/+/ePVchDHCgfmla6bJe0pIq2XGog4s5vSSr
         E5qA1jpbug7T8h05bcUjW2u2lR8eHdicnFicQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983689; x=1700588489;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLGvE6w2nI/I1UWxr+lpIoR/ViMo1XgqtZtp21yYr4U=;
        b=QLr/EOQ3stNu3lqKUrmYlWIpFSi8aKzILKwsOn2CylKYWGd6iM0WphvLKJ0p1cgBHL
         RkdS5vtAIPPgVuOC/a1AdOIFXmsNsipYcCxBw7TNkLLDe42thgtImWcKJ11dISdSNfb7
         A+HMfvTeFUquS/Im9dsLAwJUZGrKQwrN9B5PTfjLoUlEh/9YNyT8N7WY6oApR5vmiJvb
         2iLbah3Ul2WJ8NJYLf2/++6eS+5cm816y6zNfOs56YL0Ja+IZ5rIuJ5hW1T//mCMnShU
         qpwrd3AqAO6yiuHS/qgZ8dmI8KfVE9InCKpLY/pQ8Fr08XZgMvi024l5cCxB6OCgQomH
         w+Zw==
X-Gm-Message-State: AOJu0YxlJqBSb2qYt3gKNiyGQLTA7pcmX6YOfKvBI6z2XxRt7njq4SCx
	yTwGlNyYr8GojlAzJMrgCDGCxw==
X-Google-Smtp-Source: AGHT+IGJzqjH4yljoCElrUZVFhXFzpSL5gTIxu5k3uXhgG3mqXWu6aooLTEXVEWJO+CRKYVvjAIkhg==
X-Received: by 2002:a05:6830:41:b0:6d6:4557:bb2 with SMTP id d1-20020a056830004100b006d645570bb2mr3148326otp.30.1699983689582;
        Tue, 14 Nov 2023 09:41:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 37-20020a631365000000b00578afd8e012sm5838502pgt.92.2023.11.14.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:41:29 -0800 (PST)
Date: Tue, 14 Nov 2023 09:41:28 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Konstantin Runov <runebone1@gmail.com>,
	KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening fixes for v6.7-rc2
Message-ID: <202311140940.5D358293F0@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these small hardening fixes for v6.7-rc2.

Thanks!

-Kees

The following changes since commit 9cca73d7b4bfec75b2fcef751015f31691afa792:

  hwmon: (acpi_power_meter) replace open-coded kmemdup_nul (2023-10-24 14:10:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc2

for you to fetch changes up to 782ce431613cf08c3a00dca42ad925c3b1108d09:

  gcc-plugins: latent_entropy: Fix typo (args -> argc) in plugin description (2023-11-14 09:32:47 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.7-rc2

- stackleak: add declarations for global functions (Arnd Bergmann)

- gcc-plugins: randstruct: Only warn about true flexible arrays (Kees Cook)

- gcc-plugins: latent_entropy: Fix description typo (Konstantin Runov)

----------------------------------------------------------------
Arnd Bergmann (1):
      stackleak: add declarations for global functions

Kees Cook (1):
      gcc-plugins: randstruct: Only warn about true flexible arrays

Konstantin Runov (1):
      gcc-plugins: latent_entropy: Fix typo (args -> argc) in plugin description

 include/linux/stackleak.h                     |  6 ++++++
 scripts/gcc-plugins/latent_entropy_plugin.c   |  4 ++--
 scripts/gcc-plugins/randomize_layout_plugin.c | 10 ----------
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
Kees Cook
