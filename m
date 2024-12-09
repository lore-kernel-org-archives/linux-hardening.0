Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294729A0
	for <linux-hardening@vger.kernel.org>; Mon,  9 Dec 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733703381; cv=none; b=ACsqmVwJHP47SIz0y72INNYcTtyx+nbqQfotlXR7s72iN58dkjFhtXb6mCG3qLlYAfs0qqzbYvI7q8A+iVRjHHXSt8MC0zaQnmVskpfScTE5LLrZuxgZK3nBZrq/KTjS7h7nB0DtR/U5sY5UnmdPs7LVXy5CAmf4iIoCOws+VP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733703381; c=relaxed/simple;
	bh=BG0lYi8qENv1S6Z0qBZj8MIboPFVdp43e62P0arKhY8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F2a8FRqD8U+XydjaQZll7k4hZM6aY/gZD6TlmcZ8fB/KI1PX2B/7UVZHzpW5Y63dyJcWdWX9XelnR/pdNLds/jA6Tp4xyIhxz99fdbLd96SQSaK+TePjd276g3GTFkwnDbxN51h6OfdLaRdxoq7afROAiA+Qrso9FAbEyX1HVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V82cAoKt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V82cAoKt"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733703375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLoj+JdGdda/8Il0iOf2kOpmQkX1BduRIAZEjm01B2U=;
	b=V82cAoKt1hD1ukhOAYE58fpz5fdSXRVoknNzLepw69DA/bxxd7lgxN2qd5doCcdEym0Hwq
	zMTBkGaMiSd679CLoUBTg0l0WJvDTDpOa9S5gvgLNtbUADO/qyIGTt+dC1h6Blmfq4Bgqt
	we++6RBDCA0eRDgCuNeNuVrF8PcgxgM=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with
 __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <Z1P94CdlCAzDc3d3@liuwe-devbox-debian-v2>
Date: Mon, 9 Dec 2024 01:16:01 +0100
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <77790477-238D-482F-9431-FA85091685BB@linux.dev>
References: <20241015101829.94876-2-thorsten.blum@linux.dev>
 <Z1P94CdlCAzDc3d3@liuwe-devbox-debian-v2>
To: Wei Liu <wei.liu@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 7. Dec 2024, at 08:48, Wei Liu wrote:
> On Tue, Oct 15, 2024 at 12:18:29PM +0200, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> range to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Compile-tested only.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Applied to hyperv-fixes. Thanks.

This should probably not be applied anymore given the kernel test robot
build warnings. Unless I missed something and this works now?

Thanks,
Thorsten
