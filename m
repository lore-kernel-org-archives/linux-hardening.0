Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A7125CE
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO3Qatlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0F9C32788;
	Thu,  5 Oct 2023 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696504154;
	bh=pMx5pqQeQDjrMnqS2Ak24EVeDg8+F9nrpir675DqlrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mO3QatlovJ1Y2buxaCKbEVfM0NU7/nT9U+XbwOch583bi3zBhSU0sMEvXip87qE2M
	 y+owKp3cAfSU3ExAdWhd6r93T5SjFHugE5uIMRJ0fbG4Y8mLJbaSC1UxnMjoybiJFy
	 E37VRRvtwnalMCHyVgwUlH4Z7XqUuskXWiY8ZtUr3V6lVOLZcl9Z5KMQOBrTnjEd3E
	 feB0Snrbi/J1AmoMi5ryqmN3CcOfx9AGItI2CDTB9kiS086av0YVnN0obHwZRK1PP+
	 zBLAWY7NSk76SCnYCf1SToTSDoz6NYQphvK9BxElH7qpFOKPR7JKUxLVZNX0/9BVAC
	 2NrTbCPOqD8CQ==
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
References: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
Subject: Re: (subset) [PATCH] mfd: db8500-prcmu: replace deprecated strncpy
 with strscpy
Message-Id: <169650415311.686763.14245532826620345084.b4-ty@kernel.org>
Date: Thu, 05 Oct 2023 12:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2

On Wed, 27 Sep 2023 05:10:54 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect project_name to be NUL-terminated based on its use with
> pr_info:
> | 	pr_info("PRCMU firmware: %s(%d), version %d.%d.%d\n",
> | 		fw_info.version.project_name,
> | 		fw_info.version.project,
> | 		fw_info.version.api_version,
> | 		fw_info.version.func_version,
> | 		fw_info.version.errata);
> 
> [...]

Applied, thanks!

[1/1] mfd: db8500-prcmu: replace deprecated strncpy with strscpy
      commit: 5f0c4e32e8da434a83dd74a08e477c11e7efc6f7

--
Lee Jones [李琼斯]

