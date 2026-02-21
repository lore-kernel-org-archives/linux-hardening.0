Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742A256D;
	Sat, 21 Feb 2026 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771637086; cv=none; b=R6nXgFiynJ38btTsdSuoIoG2wiTdcIu/K9ot/DM10fxdVPHG7xxNbCqgUd2rT7F5zSq6dcpyAzNTtaaAeahks2Z3MIjK4hGUZsxaGmgdJOj8aRN7htbFamzgy62PUL17bdtfx7zSHX/ZMWQgDLlDy/FSNJ3I0fXlCexL6/LM8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771637086; c=relaxed/simple;
	bh=mCQgfNSG8TIVTEi9jrOXD6Csde/H0bwzHQzQGGkM0YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp12RstRIp9PViLthl++eSwb4/37a8AUtD3PN8pOlhAKkfg8zc2SWM/bpq5m8j+kB2DDKwwpqqtVzke6nFMhVeyUWxgUXdmC1f5PidKnDCLZx+Nvp+htO+ro3yqwe+x6yXGHqtK0fI9UAsGQ8Mg+x1F/Ymwvwl+CK9pOYBsQ+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMQYJmqa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMQYJmqa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yMB802Dm6y6nia1PI8Xo1TEYN8DftfBEDgtLErTni3c=; b=JMQYJmqaCWvjI+giNPUjdu7cNg
	Sm7Y71b0I08AHSXP3Y8lMq0/ZoHSzDB0Cm4dIQ33jLuUguDhFTAw8JgPE4HGXcoHl01kNIzQDmhuA
	FYHZaG2Fbpb+6g1mWuk0hjWP+eCdp+Tkr8XN5RrfrEvOLAlECVBjPszlgOK3pi/d7+Yur8GuYnC9B
	5lPtSsixDiPSEKhdcMlo+u0UCo49ZCe6+iAcq+//XR+uHqOnzzrMMf1jBqwacN5EyaS3ElNRM03vM
	1BpgZnCsJDlNUhpKeuhtaDxV+nPUiU1hubyG3BvyI11wtKxLiFTiDOarlo+K7+tQ1YKZ5awM3KzJB
	SRIwzgkg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtbjd-0000000FkKD-19wU;
	Sat, 21 Feb 2026 01:24:41 +0000
Message-ID: <d8a00dff-38ac-4a7a-b048-ec2f681dd811@infradead.org>
Date: Fri, 20 Feb 2026 17:24:40 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/26 2:12 AM, Mauro Carvalho Chehab wrote:
> Hi Jon,
> 
> This series contain several improvements for kernel-doc.
> 
> Most of the patches came from v4 of this series:
> 	https://lore.kernel.org/linux-doc/cover.1769867953.git.mchehab+huawei@kernel.org/
> 

Mauro,
Is this series available as a git tree/branch?

Or what is the base for applying this series?

Thanks.

-- 
~Randy

