Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A12BE056;
	Thu, 26 Feb 2026 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772086374; cv=none; b=T96v0JdPAl+DotKqZFqSCzZxkDz6hr6O+opUOu55YSTG+cew7Shk9RK2cyjt18XgMH7+K/MfzV6gYRB3YG1s9Y40AvOEi00oIwHOnMx9CuKeesfYxvS7dXtgweswEpWuEP6/7hvBaCuWuedkv7u4+F9qKQ112Et92Hzr/Dk/FbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772086374; c=relaxed/simple;
	bh=wum857gD/UcBYdqfPjX13dI7dp+soN1JT6+RNLDkzpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1MneZW/YtI81/enoW7SUnOaRHQku9gM4VuGEaHaMDpitmozJ7B7UEE6qNa2zFdaOTijpTRhS1rc/wDQcH+UmoxrPmuvfHq4kPlRiKaqOKJwGa18oz/oAnTDChy0rDMco02ZW8bCkMJKh9OkvZNCtXLMjd28qEUtdNiG7Wji5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b0db3a212da11f1a21c59e7364eecb8-20260226
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:3488ece2-81c1-46e5-82a4-78914bc34d65,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:89c9d04,CLOUDID:8e17a85cc01bbaec23e301c1ae65c493,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:4|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b0db3a212da11f1a21c59e7364eecb8-20260226
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1828231663; Thu, 26 Feb 2026 14:12:45 +0800
Message-ID: <d0f92b42-529e-493b-9960-581791f29ac3@kylinos.cn>
Date: Thu, 26 Feb 2026 14:12:42 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] riscv: optimize string functions and add kunit
 tests
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 akpm@linux-foundation.org, kees@kernel.org, andy@kernel.org,
 ebiggers@kernel.org, martin.petersen@oracle.com,
 herbert@gondor.apana.org.au, samuel.holland@sifive.com,
 ajones@ventanamicro.com, conor.dooley@microchip.com, charlie@rivosinc.com,
 nathan@kernel.org, linusw@kernel.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <20260130025018.172925-1-jiangfeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/30 10:50, Feng Jiang wrote:
> This series provides optimized implementations of strnlen(), strchr(),
> and strrchr() for the RISC-V architecture. The strnlen() implementation
> is derived from the existing optimized strlen(). For strchr() and
> strrchr(), the current versions use simple byte-by-byte assembly logic,
> which will serve as a baseline for future Zbb-based optimizations.

Hi Paul,

I'm very sorry, I dropped you from the 'To' list by mistake in v7.
Adding you back now for visibility.

-- 
With Best Regards,
Feng Jiang

