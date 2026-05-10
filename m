Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B0381B06;
	Sun, 10 May 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416343; cv=none; b=f+9fPZKReefjyxtG0WN7I582lN+e5Rr8lW2zwkbEPVa62Hlguznm9td9fINLkqNd0kE4brkPpLXNSV1/AbAenxBIDwgwyK37F4okMlKqKvX336EgGALt/UgDGfdLi1CwNXH42SSo+ewD6MbdsdtznnW5Du8S8KenA6/a3uyKdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416343; c=relaxed/simple;
	bh=PfAtiR22BeLI1xNkWhQObSwYDHOrQpp5c0BjbJTPJhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X1wUcTqEa6R3iBNI+qxmp3uGC8n/GCIGFEZ1ZeCoXAKquaX+1nRpYoGx+ZcJGIUBfaTEzoOS8P7Bu8QCS5QuJBnzL2EuooYAumrLkagpxQq1IXDnr6DVJB14OV4lG9mp9L12bm2SaphJBzpLbUBVKIr5+9r3xEAENqwlk2EO1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzzHPD46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzzHPD46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53031C2BCB8;
	Sun, 10 May 2026 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416343;
	bh=PfAtiR22BeLI1xNkWhQObSwYDHOrQpp5c0BjbJTPJhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pzzHPD46ljrfTpClixgvb4yANKVJ3v32sIl13C8+ea2jLszSd0oPgFXSSbP5Duv9f
	 QgfbscxCIdx2reDe4iTULpGdBFZ2AouPjzwdjbXqaLJ9JpJLD5DcEXQd+ISSb9GqV+
	 kZrGaFjVM2IPkBzH0ScNm1Nq60jYspEAwOPGW6BSrMC5BBaqxRmJwzAVkGHuvkHTtP
	 BlM0ij6KRT8uDlbAYyyb5hd2ckkXy/Zd61r3Ap9luWAxpWFWDF3QS2yyBEK4kzkZa3
	 PC28WofTtsac7virgk4Bc0WZOsBesX4ghbjyP0C1+Y6JEUQYIKO5BzsfjKoGfMnPP8
	 sgJqPMOxl+77w==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, Rosen Penev <rosenp@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260306222457.8400-1-rosenp@gmail.com>
References: <20260306222457.8400-1-rosenp@gmail.com>
Subject: Re: [PATCHv2 0/2] phy: miphy28lp: build and simplify allocation
Message-Id: <177841633994.434434.11599287536410953289.b4-ty@kernel.org>
Date: Sun, 10 May 2026 18:02:19 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 06 Mar 2026 14:24:55 -0800, Rosen Penev wrote:
> First patch allows compilation on at least x86.
> 
> Second uses a flexible array member to simplify allocation.
> 
> v2: add first patch and fix second.
> 
> Rosen Penev (2):
>   phy: miphy28lp: add COMPILE_TEST
>   phy: miphy28lp: kzalloc + kcalloc to single kzalloc
> 
> [...]

Applied, thanks!

[1/2] phy: miphy28lp: add COMPILE_TEST
      commit: cc68a1728abfcbde12d36015f244046ae74ddd44
[2/2] phy: miphy28lp: kzalloc + kcalloc to single kzalloc
      commit: f3508a61c892c592e4e893a3681e568a5c671027

Best regards,
-- 
~Vinod


