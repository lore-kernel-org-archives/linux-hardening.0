Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4031211463;
	Mon,  7 Apr 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042645; cv=none; b=WG2afNGN8368nLHyHfueKZOywx0K6FvSYYdfB25pf5vzWpjkK3zqgaKFEIoD6UyJYdeRtAmA9ruCN2b5Zlp45eYukQuTobajKKPfkU3eEU/MB9uhZz+rhXrvpufboSTN22ButA/pYVFe52VTljoCbS0SSrZg1ko0B0tQ9twC5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042645; c=relaxed/simple;
	bh=jhTJeVtVDMXQRH/VF9ulN8l8CT0ZrTieHJvSi/kgA70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tau6EwAAx32K0fZpZgYnutrs4xHFdpzO5gBLsUfzZeLtv1RP2pt06MYSmDZmQ4161YKMVgvl9ZeSju1tjF2sYXm158uFX10B/YpSlUXSWPCV6uPYesSBRDLjiETeb02yGGYZH6/GgHPyvgJab34EWuvYcUTZmkgo+Mn2XDYcutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUqL6lR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUqL6lR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBE9C4CEE9;
	Mon,  7 Apr 2025 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042645;
	bh=jhTJeVtVDMXQRH/VF9ulN8l8CT0ZrTieHJvSi/kgA70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUqL6lR4CYGfNxgV2cZQdkGpUU4A6nZTAFDBcXTcbwk9INGny4mpuNSfhsEpPg2w0
	 YFKb+oauj9VPReQVQTbCqbiEwszED3sWbmErZWSgYiuSLRzYmD+v8BegQHbaXBKIVC
	 YWN7PTCVkTxu7vFKmhWoFfQhApKjVMbLij6BXFtRQZh1D3EFILM0tcz1TDTXmofKGh
	 BmqlOyEW7qLf2/2ogPdTDplaDL12CWP/5G8iML2g55YK80UmFtQ0YVdZyi2o1A2xUt
	 aHX1+ilQJ4+ny/Jzz4jxJjQgBy3/yQBRDnc6iN7j22vxMMQhcdgb41dDEejnEL113v
	 KnJMIpLSdoRBQ==
Date: Mon, 7 Apr 2025 09:17:21 -0700
From: Kees Cook <kees@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
Message-ID: <202504070912.8BB9AD0AE@keescook>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>

On Mon, Apr 07, 2025 at 09:15:04PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> strstarts() is frequently invoked to test if a string has another string
> as prefix, but its performance is degraded by the strlen() loop contained.
> 
> Improve its performance by eliminating the strlen() loop.

So, as Andy already said: no, this is very unlikely to be a performance
improvement, and if it is, you'll need to show the numbers (and likely
the reason _why_, in the form of assembly output, etc).

The reason this isn't going to be an improvement is because
strlen($string_constant) is optimized by the compiler into a integral
constant value. So you'd be replacing a potentially inline constant with
an explicit function call. That will be much more expensive.

With almost 300 users:
$ git grep 'strstarts' | wc -l
198

Only 38 are _not_ using a string constant:
$ git grep 'strstarts' | grep -v '"' | wc -l
38

Additionally, there is no "loop". strlen() of a runtime string would be
evaluated once.

-Kees

-- 
Kees Cook
