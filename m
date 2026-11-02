Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793645255;
	b=lWrtCremi9A5YfIEkGjrN26N9dgBPB6YwTFK1VqOo6ftVdU3GcHaPCKEZv9XY193Dbn0
	 HkGn3wWvu5Ci/SPq8wnY5e4xpIOTxo0mtGbrmH125sYmhlHEzDxsPnmO0JwZezSr8LmXC
	 0IpLA/rxCZhdHrPU6U6Zjq6PtsFO0l6NIs4NraMvnxOlTm+laG3iPvcg6GXctGYIJ7Gpe
	 u7kbk7kUhwGfhUP4z/TVLNvgiLWYb+uSFfReruNSZDC4GK54Cys4ufRGxx82DNZkHQSOD
	 a4R8uzCzhS0KNQg6F1kPMAOJ9B1ewUEtziXsR9QHnj6C6wuZ3ODbZEcuic43IZSay3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645255;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ix7wSAfwPGifAh2lTDY+w3AqM7JwyOsKHL1ku25FRys=;
	b=E/Dt4v8NXVwThWC+3r1+/1nCUjnSX/yhtHNJwPb+4AXVyckW7MJTcgvSVhrx7wNgHE3X
	 Fe3nTZ5pP6l0+2W3JrsnP0fjMHmjPIL1Ffu7+Aq9+1qgjeiVlmjXWSvKdmYUZk5mV4C33
	 32AB0nTUpzN7RTfNc3TkBJt6VxROZtFWgBDXUMIggTJ8Quln55i2Y+xtDZcWSsXJJKauY
	 M+XXct7ufR+f/u5WRE+WlSubMG40m4nOVs/tYcoiu29BTfVqZs/SBKqrHg2pRcylM/YW0
	 IxBXEix+z45KqRRAuASgTsiyPVONaeXbnaLU8k0uADDu5uW0q0jqEScomSeKguSmDAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=J+sIxte2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.16
Received: from sender-op-o16.zoho.eu (sender-op-o16.zoho.eu [136.143.169.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404A606A326;
	Mon,  2 Nov 2026 18:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C404A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=J+sIxte2
ARC-Seal: i=1; a=rsa-sha256; t=1793645234; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZiZBcytF/xhOqfuhBKZyTZw1vXHr3ukI48Qp9yk1e4Tmcm5IuvGYIhcgBPnaDbU/YZ2kjIsWpGuYGYyy1O0YCIvWdSe1WKNIvhyJ2WSGQvl4AwTxP2W7qDOXpLTnxGswtHhtPq5ZgIynwIepb+GM99hOhTc9FBABseRshwo/Kns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793645234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ix7wSAfwPGifAh2lTDY+w3AqM7JwyOsKHL1ku25FRys=; 
	b=YIT1dzhVDd+zFaRXY5FO97lEKTMbB82HQKXDlAB0bMKHIvfv+xn+TwjP1DfQA+dM8/F2zPtjpOZBZfdD2Bm+FbJqhWqQ3yjUxh3amPu5wS1loLUq40Q19XPIdITYVtVe9iiDFSz1Wgj8FbIa7s+Z6F1PcOYzQXqVAx4sfb3eSao=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=J+sIxte2B8OvAbYCml9WH9zaPRSfk21jw52vMSauXy9SVrZAOQuKYt9kLm5UWIUK1u/GfnFTJy2X6DoVvOfcRQ8LYl3QXH6eN8gFFh85ZMBoUQ2LoRDH22/aQAqeOHdwqf4hO0ND0bCqhEQ3hUrKUqvLfOssfdnaLXLzS8QJSF4=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=Ix7wSAfwPGifAh2lTDY+w3AqM7JwyOsKHL1ku25FRys=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793645233028997.2687494077945;
	Mon, 2 Nov 2026 19:47:13 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] fortify: Disable colored diagnostics in test_fortify.sh
Date: Mon, 02 Nov 2026 20:20:03 +0200
Message-ID: <20261102-ping-fortify-1@iav.lv>
In-Reply-To: <20260924-fortify-test-color-v1-1-37f6d50e31ec@iav.lv>
References: <20260924-fortify-test-color-v1-1-37f6d50e31ec@iav.lv>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Kees,

Gentle ping: Nathan and Nicolas reviewed this on Sep 25.
Could you pick it up?
