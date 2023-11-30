Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N2/jxy/C"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B610DC
	for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 13:59:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbe716b511so1459674b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Nov 2023 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381584; x=1701986384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+MjKIfeA6c7V+SkVK7ESwNu4zKp4IlbbMa3hRtTv3E=;
        b=N2/jxy/CKVwt902heLKJ/9RkwWIO9NF5/UWrAhqO2YzddpXpIr089+xPHNARO4wj0d
         Xt1g9n0Gs7fuNnNEGNYYKinblwJozKqfB31UPWP/01ogmvDUiosP+4SB3yBmuFvBttRc
         8/tLblPYi+DEweOrleF+tSH6qbRfbv06dkdYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381584; x=1701986384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+MjKIfeA6c7V+SkVK7ESwNu4zKp4IlbbMa3hRtTv3E=;
        b=Mru6kdRHnxlwq1wfA8T0WBTMz5LY7cyv/mW9MsjkmGIl0T89l1LgvaKvl5RMHcRwWC
         SYNnZ9vOCTrfWBvfmlFZ1Gg7zGONUDaRFdYaNgy3FFDLJCRbOA+USGcK5wqxp8zfha+b
         IfTdiWlSf+LFUE5Oa4VsKZJv1NVfJv3Sy0TlfiVCZQQOrqO5JCtDLpC1URNsNam5xqw9
         ymCcDfRTFkSMVq0O0jE0bGG0onkrbXQe+50nxODR+qna1LWd1vas5/jFgSRGjhKhCcuS
         uVyABZhTg07O9HBRW3aeaw6F0VRiezpEAQmkeQ1ldC3VNqVyvjgk1phKUFVA1R+M/0Vp
         wnUw==
X-Gm-Message-State: AOJu0Yz6p4xI3hvGjtLEV6g46WgBAYRMGdinyYWk4Dccr7VADW/5xYo5
	dxoNZDgXBAwGhT1LemHz2h1b/A==
X-Google-Smtp-Source: AGHT+IHnOCwCjzZBfKxzRTjC4fQ8XP/8fQObomS+nCckrMFuuQt1ZNZTYjBCrPSpglsbSfTmpIMqEQ==
X-Received: by 2002:a05:6a00:2d95:b0:6cd:dece:b73d with SMTP id fb21-20020a056a002d9500b006cddeceb73dmr6204554pfb.18.1701381584754;
        Thu, 30 Nov 2023 13:59:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79d05000000b006cbcd08ed56sm1683994pfp.56.2023.11.30.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:59:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Kees Cook <keescook@chromium.org>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Gurucharan G <gurucharanx.g@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] i40e: Annotate struct i40e_qvlist_info with __counted_by
Date: Thu, 30 Nov 2023 13:59:37 -0800
Message-Id: <170138157431.3648624.12161951188288893323.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003231838.work.510-kees@kernel.org>
References: <20231003231838.work.510-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Oct 2023 16:18:38 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct i40e_qvlist_info.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] i40e: Annotate struct i40e_qvlist_info with __counted_by
      https://git.kernel.org/kees/c/da2e08d4630a

Take care,

-- 
Kees Cook

