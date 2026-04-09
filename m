Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7C3195FC;
	Thu,  9 Apr 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761052; cv=none; b=DjzWtUp8SBtqjszlIczIiXRTPPE3NDpyVrLuyjW0pIF5DP1q/mVl8GAmvGXtYYNd8EtfmYBQO4kZqnS877ZSz4Cs8nE/9d+dPZisv6k+l3exyRYnNJwt5AqJYKSa1KId+NwTO5Q9zlCgjn2lbVZh3bn99NO7lch7ZUBqv2TUPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761052; c=relaxed/simple;
	bh=IPeoAVtT9EHDF6aPjjI+wdSK9q7LN6aX9mvkQMkKXp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CChUauWJqd1Wirse3PcmJyiE54OC9TpYItBlnpBUtc7cW98dLoIT8B7voTAFS4pk09+XzawLLHHh0ygstxWGarmc9z/Lf0X72GjkKT2JrBFEVyecvtTbFfdbI4ghUd4Blw1TDF2GVt1ODDGgY9HHQzK1gJNtuL9Dfho4fxx6NSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mpTNtwND; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mpTNtwND"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Izmrn4bTgkH34T79QJgGIegQQmlBprQZszJadAA8sVY=; b=mpTNtwNDlFUKqH1NQR6TrxD9cV
	/2zUQld9S59sFP40j1hKTLZUUyDcEfEMY3spHK+aP6pbmTyUDzZMC8E2+X8xjspgNZMzNw0JrsEWC
	sTNNoJ3V7D1cNgp+bnKdDXX5N/gZgC2byH86KxAFZLZ/DeXFjoqNBm48gs4O/fHJ7W3WSK5EkQ1Uc
	zA0SWdvIJnFbam9uAjq+oc5JRT9iGiwEsoBylQcrDll47I8yN10Cwkaiaaz/5ngX7XaHDehQJr/C5
	YkM3RQoB3ZmwvrBIRS8dH+H6PbEH+12WgG7ckh73TAEyuc/Q24SoaDjchHOopz8puJifqyqGFa3cQ
	PGIXTaOw==;
Received: from [177.189.74.94] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wAuZ4-00E4NP-VM; Thu, 09 Apr 2026 20:57:19 +0200
Message-ID: <5b718d36-988f-9c74-619d-43ed57b6f32f@igalia.com>
Date: Thu, 9 Apr 2026 15:57:14 -0300
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
To: Kees Cook <kees@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-hardening@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
 <202604051301.skV8JLnH-lkp@intel.com> <202604090930.6FAF3E5A@keescook>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202604090930.6FAF3E5A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2026 13:31, Kees Cook wrote:
> On Tue, Apr 07, 2026 at 11:58:56AM +0800, kernel test robot wrote:
>> Hi Guilherme,
>>
>> kernel test robot noticed the following build errors:
>> [...]
>>>> ERROR: modpost: "core_kernel_text" [fs/pstore/pstore.ko] undefined!
> 
> Oops, doing a modular PSTORE build shows this error even with v2. I've dropped the
> patch from the tree for now.
> 
> -Kees
> 

Thanks Kees (and the kernel robot!) for pointing that, I'll fix it and
re-submit =)
