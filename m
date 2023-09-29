Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159542C15
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 19:00:15 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F51AB
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c735473d1aso21346065ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014014; x=1696618814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWeOES3N3vd1Zvv6AwyKn/S5xF8EcGUaGZeIj8wdjdU=;
        b=HmUFAh0zkPL1XTlG3DZ98Lpg/V1SZuEoX3aE4Kq4pkbqrC/H5wIzMA5Ey8VsHEKpWi
         yVIgAWX00Y05jmBg31jtYE0BWtl1wsLbgOvemDcQMYAbhvOv2CroSlN2gc/aC1DsIZvx
         S5UPmWcHXmwWMUaXbAqPSB6V5YPgKaXCe/rr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014014; x=1696618814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWeOES3N3vd1Zvv6AwyKn/S5xF8EcGUaGZeIj8wdjdU=;
        b=pE4+m6ES9RZdnokmR1g/TLOSyl/GDx5EvzEo6eC1/l5PD55sW+V6whdct7QwcaLF6z
         vrXc5axQ8o0luJUqzGoDrRiJtJVTc7i1rCfTJvd40ooA9ESvwNXCeVUPBv08Tmj8D5Jv
         DGtcfqvsM7aUTs/J1/pww7F6JWCrI8G9qO5oIVZrZGaL6qv8WftLHsK4Wfq0hodmwCTG
         gPtp2MsotyzoxknLAEuw/RIbn5Fsd0opr6amONCX6Pyv9Z866WSVksbLsq8on/k263Eb
         oVVC3uVS/z3DtCc1ep1N98MlJMv18RuuuUzRl5ZYeLDxXhi2oVTcCl650PNQsJMxuL23
         YKWw==
X-Gm-Message-State: AOJu0YzzsKGUkjgDf/aGJp7c0ALCEtIRsJXv3UAsMhv2xI83r/Hx1VoY
	0qpbxNB1qXjBPEjQ7c2PWp414A==
X-Google-Smtp-Source: AGHT+IFalx0Un4U0EyJJTXitS7mv7fMxN2PPC27u8ial/BdekWtfArKvqJ9zOOkHTfSVfLFaLHHVqg==
X-Received: by 2002:a17:902:da86:b0:1c6:bb3:29e6 with SMTP id j6-20020a170902da8600b001c60bb329e6mr5492246plx.16.1696014014059;
        Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c73d829fb0sm3014497plb.32.2023.09.29.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:00:13 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc_sysfs: refactor deprecated strncpy
Date: Fri, 29 Sep 2023 12:00:05 -0700
Message-Id: <169601400133.3011505.5557490241780172507.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
References: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sep 2023 07:47:29 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We've already calculated bounds, possible truncation with '\0' or '\n'
> and manually NUL-terminated. The situation is now just a literal byte
> copy from one buffer to another, let's treat it as such and use a less
> ambiguous interface in memcpy.
> 
> [...]

Applied to for-next/hardening, thanks! (Subject updated...)

Take care,

-- 
Kees Cook

