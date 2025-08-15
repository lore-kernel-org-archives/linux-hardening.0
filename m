Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA91E834E
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268891; cv=none; b=C0+/k+wJFR1ECmrSYKjg7FOF5nrdRRgT6FXz8tdpGSy8TaznjtTBz6QJOu/M+w7a5NmsVSXyUn9RYAmE4RfcsQfUEBOU3quQybBIUiUPV3Mumsi48nEhRs/qzJOgaMJhIMrlEuowK6hJlDwzSHo7DPZtF4x81W9adJ4yDsautkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268891; c=relaxed/simple;
	bh=YPc2WkiuWNKrwt4/CCK+S9Lx2u3fgAqe1VQTLuurmgA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p7BNonYy7dTFESdNof0/4sCubD77IJOakXGRR2yjJ8OOj3cT1pGdNn6WWnEdM55iW+hBbGOmrD8nEgZhPwFBvBsIx3De9/AYWC+khHzXwf4LFNLfPU0PEBgbf/GH7XGpPPxt+Ve8RWmWhbetFtejZ1On8jDdvOMM4fEBwmwA5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GUl7cxHL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GUl7cxHL"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755268877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvL37IC/92eRm8eEeLClw7EjlC7L2Hs69WqmVKW3jAU=;
	b=GUl7cxHLjG8yqf/4TtdlmME4eNJU5i9H34q91NXQvxnhtUcRZ/7WOyVIHWo8ZOQifwg6ye
	GBDybV3X00+IB6dsAPZr4x0I+qbmnfuxaooUz7DEw0zNhehC4QW9Bck+9o8GPZ/ZvBHQRm
	UR3bEIRmPDU2361vinmNf1OELTgkkh4=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aJ9EPQNk2bcOMP1h@aspen.lan>
Date: Fri, 15 Aug 2025 16:40:56 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <73C106D1-C7F8-415C-9BC2-89607C839265@linux.dev>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan> <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
 <aJ8cyXzMaa9b7ppN@aspen.lan> <72F30E3D-2887-4494-B58C-2042AC880C1B@linux.dev>
 <aJ9EPQNk2bcOMP1h@aspen.lan>
To: Daniel Thompson <daniel@riscstar.com>
X-Migadu-Flow: FLOW_OUT

On 15. Aug 2025, at 16:29, Daniel Thompson wrote:
> 
> I like the extra diligence of checking the trailing quote but perhaps
> combine the two if statements (so we only chomp the quotes if there
> are two).

Ok.

Should I replace kdb_strdup() with kdb_strdup_dequote() because it also
handles unquoted strings or do we want to keep both versions? It's only
used in a few places where kdb_strdup_dequote() would also work.

Thanks,
Thorsten

