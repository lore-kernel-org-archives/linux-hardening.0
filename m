Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C94B5CDB;
	Thu, 17 Sep 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639235; cv=none; b=qA0n9SupkouBBDHyGgzaQ+I5MszcpN1evLvCDSq+K6V0lF9f4qezlComfz1uNK5WYBnwBz1iIorbaZVr1hNzKfW77sTggqWYl3Bkz+gij8bLf1yOVYZmKgMPnASTP/Y2tHI3rDDxFLNGPS7GsQqMWv1HpzX0DRZ4xXHqdnLHEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639235; c=relaxed/simple;
	bh=+USMjIfNP3uZFioaRcdNSDXepCx2MVhcpY1yM/G+cUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahye0pGVh8FYQy37c+eHjg97NwF+bTZ1sv8N+s2wnmAkaLDEmZdaF1Mejsw7oGVNx7ZSg7hdvcs5kwwoLuhyLwbGAkzxolZj58xuK+uybq5uJhOw6JYyqn+GsrgP9dld3FmkxbKwovCUncThkk7/dVWynZKpKK5iPvp1R1Ao0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQTb5ShW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQTb5ShW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6DA1F000FF;
	Thu, 17 Sep 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639223;
	bh=KMtp8Z9WPhLzD88mx0x4QBJhT5sxUdhnq9HfYO1RsoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JQTb5ShW2EGlCHH0KFxi0QSAJa+kywMbKYFjy4+uQ9QEtddjzlHJARjoBmsTdW7pi
	 BwinW3XkizbE+K/m3puN4wWvEfL7j/c9w1tj9DHe4ponDn72Bb++zLnscoKq2OGogi
	 PXdtg1S9ktBP4upgBlSfRiS3wlMnono+5FJVYBHl/bFXmDaJC7HWKaoSNgq6pwWCLo
	 8yjuE/wzXJoYnfpR3u1Zf46sCbpNcE6iPTka/cKeHbMC5FY76GRIJ4RMjOzg0jhejD
	 c+UUaca+mgy0LXxnal6q1min858S714FzCh21XZ6bOAsJOXbL4vcV9iJXI08+e5M31
	 igAUXJOgrLZAw==
Date: Thu, 17 Sep 2026 12:00:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v7 9/9] arm64: defconfig: Enable CAMSS OPE driver
Message-ID: <20260917-modern-corgi-of-memory-6d9082@quoll>
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
 <20260915-camss-isp-ope-v7-9-77b13d131d3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-camss-isp-ope-v7-9-77b13d131d3d@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 10:11:12AM +0200, Loic Poulain wrote:
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> 
> Add CONFIG_VIDEO_QCOM_CAMSS_OPE=m to enable the Offline Processing Engine
> driver for Agatti and Shikra platforms (e.g. Arduino UNO Q).

Unfortunately same comment as usually... Samsung Agatti? How anyone
outside Qualcomm can figure that out?


Best regards,
Krzysztof

