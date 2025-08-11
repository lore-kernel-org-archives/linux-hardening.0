Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B42E339E
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948244; cv=none; b=KJXdSu2CC+KAq7WnA8IG9eRDg3skuwDA0XEjtJvwlrpWfO0h7CmrzD45tRKMS93XnGQuFoUJWjVu+NCya9Gyd/zFYtYM+BBYqgwBFO+Q1nAeLZsNEOHqmcpsc4ZqEJOZ3wOJWN9rx/HbdQdj/mDUyHI9FZLS17SdZqV/7Ecwt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948244; c=relaxed/simple;
	bh=qWIsTeGtfPbRasrX/LrieZfHdO0fcKIavaM4IK2K0+w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fCxuj2Fs8YTQQXo1i+OEC+Ym07c1mJLR2DdBstcWsy16oq96Be3yaAGjCUyqqVnAXDLclX2bvrYGtyVgXK0usZkfs7I3DdKPrzykl5d3O2LwVeEopf7a0ySWe8RWOJv4Vac5a0nVjjKZbGsoYZj+AtLkHlNp2QwPvnGFvgAcQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v/OKbfwY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/OKbfwY"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754948238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWIsTeGtfPbRasrX/LrieZfHdO0fcKIavaM4IK2K0+w=;
	b=v/OKbfwYchKtDxUTbSjUkOUPMdG9ZJ2fvL+Xmj0O4uyf1fmB8UYZ0Ox3SR1707b+qhGtLp
	EWrW6Z6u8MXpTV5+dR9zK8rZ9BdKtZI+NzxtTx+jI4/JKo+I8s947PwHmDQhl6U38PRHJ7
	6HBVG9383DfxMp/Sq4B+tRIbZ7WjhuA=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in
 vkdb_printf()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
Date: Mon, 11 Aug 2025 23:37:04 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3C68B943-D11D-40AD-9B3D-C35CA38D44AB@linux.dev>
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
 <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
 <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
 <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

On 11. Aug 2025, at 20:13, Doug Anderson wrote:
> Do you want to send a v2 that switches it to memmove()?

Yes, I might just need a day or two.

Thanks,
Thorsten

