Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D89363C52;
	Fri, 13 Mar 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433378; cv=none; b=aNinlUNEWF7OiIJ+B5TCZBIA0Vx3Fvh3a5mnvChBDlb9mR5O0jW7GOrA9BwTXPRREEgxC8KcMDja6dy9wK3hNqx5ORY5kIJ4CoUBTYuzD3eixvs8apksCIo10tGu8wPE0Coj608moo4zsSvPONn6s5m/DQTN08PqrpbamjrGgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433378; c=relaxed/simple;
	bh=ssLot8CvJEC/OE2BljVORjbH93yhROmisTq+nPGJp+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxP532K0BmjQB91Gx9oc0vi8NNhsdI7F+6zvnh+H+HOpgBcsQgsopVRo/vJdirvhgyagoO7HCLzkaz9tSZOoC4gFInvOfUiiO+rAdrm0MIklFTpPZxP7lMc/wF35HDXkm2sXvhIdnFv1NBk4axtWQgvC6Cmgzqj9udDlm79mZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=l3H03z8W; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="l3H03z8W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ssLot8CvJEC/OE2BljVORjbH93yhROmisTq+nPGJp+M=; b=l3H03z8WdhwpUibCsNhRA41fug
	G2ruyLNuFlsVpqVYqU8ORenSKVw2ybMXWzted9v4IgsnHvNbnbiW1ux76q178+0C0aGY6YONdD2bf
	n9KGMetoM/LSuMHAUW6LMYmPn0DDTY9Hs3HzKY6vyiTNryiOHbKTmS/IsQOeMYhbjMcrRvVrxf6NW
	a+E3oVypsBAu+00mE5sCqa9WHJyvzmVzjkjBqFOXt4wzL/DqEWnNFFpGXFmRXvi3BnXS1fw/afmRY
	4BYp5TWJQ91gWwpWTa5SQf6WEVseP4wUTdrToXjv3jTxW1fLeGr1dGXBXNXuGmJEZdvKgSPlXTq6F
	5aEajDTA==;
Received: from [179.93.15.111] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w1925-00FQHf-4m; Fri, 13 Mar 2026 21:22:53 +0100
Message-ID: <b98ccac6-01ed-7ad3-8532-5221edfc240a@igalia.com>
Date: Fri, 13 Mar 2026 17:22:49 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Content-Language: en-US
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kees@kernel.org, tony.luck@intel.com,
 kernel-dev@igalia.com, kernel@gpiccoli.net,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260313201010.1622406-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bah...

Forgot to mention one important thing: this was tested fully on x86 and
build-tested in all other arches I could find that implement KASLR, like
arm64, riscv, ppc, mips, loongarch, S390.
Cheers,

Guilherme
