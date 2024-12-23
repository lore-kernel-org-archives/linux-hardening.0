Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CC185B4C
	for <linux-hardening@vger.kernel.org>; Mon, 23 Dec 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939671; cv=none; b=J+oDnMqmz+LFoSzyVtTAXrmByEZ4ZR7vED/YokSFEWDnB2V+eAQTN3VmjPtQIlLwoBXKQDChn6TK94kHUrWF083axNV/9cqgpCWjGZUXpoGJsWwxbugiu1rou0OVLUhyGPcbPPNToMxEfaSMSCwqE9oxZQJxnBcP/M2rXxfo39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939671; c=relaxed/simple;
	bh=4ahCFuU7clUrGou7iErZdZolhTn7t0Sk2+czTt2uZuY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gLhruMraXuUpvvEWdo3un4MlvtCP3sWuV863230Hs52YddE2Hvp4BU9Jvn7cb+iZAGwloPL2ewcG9ZWQSXXQ5h9+/08VCGMFiXAEWJhB8TrRuRzO8fH9YAFt2wIZdFRdBMCcdowfUnQ1ZcO8Y5Laqw+CFdwiPA6jGExoZRzAIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KBeO1QBl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KBeO1QBl"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734939655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hH+En7lYpNxr/MhBj1Xan3maLqDPbCX7PuOWLPIjvE=;
	b=KBeO1QBlI1Kq1Qzc1KljsNkFxMR4A+Gp3FdjbVgGZP19gq13Rv0BzRXe70Y+OFF4G3GmPt
	rPOjGzSMU3rR+pHBNQF+83+ZwDERP3JF+T7nMuEZ25n37dAX9FpcZdq4t/vmVz4rb0ayVZ
	Pij/347AjusT7+gE2vpylEwZIepSQQ8=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] alpha: Replace one-element array with flexible
 array member
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202412222144.61622A2@keescook>
Date: Mon, 23 Dec 2024 08:40:38 +0100
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>,
 linux-hardening@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2248C26D-E4E4-4993-BF0A-96A613D1D4F0@linux.dev>
References: <20241220192020.1667-3-thorsten.blum@linux.dev>
 <202412222144.61622A2@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 23. Dec 2024, at 06:46, Kees Cook wrote:
> On Fri, Dec 20, 2024 at 08:20:20PM +0100, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible array
>> member in the struct crb_struct.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> Seems like this could use __counted_by(map_entries) as well?

Yes, but alpha doesn't seem to support __counted_by() yet. Does it still
make sense to add it then?

Thanks,
Thorsten
