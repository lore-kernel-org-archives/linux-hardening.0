Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14B39280C;
	Mon, 30 Mar 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886531; cv=none; b=UFKathAbZMUdMANSBqa6wIF43uSDyU0atauEkK7FWOMKvYpSDN/tKkMzFlWf3atGjxYV0y0FfouMt/dkDVC5YwBM0dp+R0g1JzGL74xwM7SsuTd2kciPQUfORgp5ols4x0flIHsxmaI4DzCIi8J9cewVc/2pR1fhSpHXiLosSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886531; c=relaxed/simple;
	bh=nHErpoaB21P+5U8WgdtpI9OnGAIWmOuCnQZG0K7rhgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/7FZjDvZ8BJyyRH/gpj/MODfeqOdMNhEc6rhQlAOorvpHKxeue65a0f6Dwpml3hRvvk/Mi4z3PZIbHa5ZxeCQMxDFIvkp3WgsD1rdH9lClwIlNnL4Sg16xIgFxDM/CGrmLwIVzFnfz0XU3HuQSz2znoQiG69y8WRINw0IN/xX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd2UrmBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd2UrmBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFC8C2BCB3;
	Mon, 30 Mar 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774886531;
	bh=nHErpoaB21P+5U8WgdtpI9OnGAIWmOuCnQZG0K7rhgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yd2UrmBqiSe5x+BwamEooFF0vMYKBa4FhlNmq6OkMAgudS3FPe+SLwqTPFi1fOyJS
	 Z8YifU63oQJRIEpvKQisQfYknieerl7W0kUKORHbPClj15PhTbfhtPsu0S9kKTiVVr
	 bVS3aYk42qOSr7pcU/vJ9YFbvcu6OErei8RP+Nf0hLJWM8qc4YkcF+26/uZfCxjJMh
	 boIErIQ4abQXYlrQnpH5TRec0TXUNB6jcUVPBIPAa67C3ftSVMUPU3pkzqehPBGTnF
	 BtnbdfHHFrHEWrwAMU0/IPzBkK9i9samaUQMIc6YXa4G+Ia37pKAbxnaSyGNX6jGti
	 r5sxhpWF0URpQ==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: wcnss: simplify allocation of req
Date: Mon, 30 Mar 2026 11:01:29 -0500
Message-ID: <177488647768.633011.8570287686963490351.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327025534.7864-1-rosenp@gmail.com>
References: <20260327025534.7864-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 26 Mar 2026 19:55:34 -0700, Rosen Penev wrote:
> Get rid of automatic kfree and move allocation down to where it's used.
> 
> Use kzalloc_flex as we're dealing with a flexible array member.
> 
> Use struct_size to avoid some pointer math.
> 
> Add __counted_by for extra runtime analysis. Move the counting variable
> assignment to right after allocation as required by __counted_by.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: wcnss: simplify allocation of req
      commit: 908061f0ad30aa08ce211c6a8f95d29102e570bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
