Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B32D6E61;
	Wed,  3 Sep 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879650; cv=none; b=QuIaveviGd85jiLPi2UBtIM6KER2wwyM045C2BN9fTe+aQfPZfjiURvsrDdvsFY090q5bBsGOH5BwP5iJUrUbO8UGNjUVFVt/oux1JK4JcJ3RP2Lslz2CRyJh5+i6GO0HmpOTXXl/8owae/tjposSCWS+we+iCkBLcQLDkkrsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879650; c=relaxed/simple;
	bh=zc8gkB3r3ly4dKmAy7cMH8HtD1IHK8dkAEfBpuNNzns=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UCM3XB8PGZWvDy76jac8yHhVF6MxodWFezCNaG9YHLtu17w2/+9PY80qn0PydZCCswiG7RgTw1/3/SwSPZ3RpL/72Tbx8Fsboa9eaUwWz4B7O2gNQ4zAjymNGtXgO6GM/RtnXEiC/PeVkARHcQT4jtOr0iOAmct4Pbo5oSW07nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GSYt7p1g; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GSYt7p1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756879645;
	bh=4RROh9iqQ70OdBywmW1IULQcZq8kweW4OW0QocIf8EY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=GSYt7p1g4bETO9d6Qq8Y5QOvEUe42ZM625lNOjYH+OOczlvKkSlbOn09/ufRp4XfZ
	 /et9W1u79/dBVZYfAdiSPWGbocL1uHaGz/HqQE6pSBs52GRUY3GnGJbjvwn2U53KR+
	 mRmemqbaug9is1yOMIsfZrrIaxPTY0pQk1BSvXgJpztqfeicGoY6TtHY96JD8YxrJr
	 i0iiy03mDtRx8apj5TcfPYGFP3V2yxoCmiM2j2udEh6YsjO3T3qGOL4nOMTB5jKxGp
	 WueU2FKz47+e9inVRGwvv7OgDVoNnwyqxy5Xf3I2x64EBU1Hn4CjVK8VMG8BrDsPuj
	 K4+GGYvegHX5w==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 59A716E02C;
	Wed,  3 Sep 2025 14:07:24 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131743.86905-2-krzysztof.kozlowski@linaro.org>
References: <20250819131743.86905-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Minor whitespace cleanup
Message-Id: <175687964426.808220.6591590873945932888.b4-ty@codeconstruct.com.au>
Date: Wed, 03 Sep 2025 15:37:24 +0930
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 19 Aug 2025 15:17:44 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

