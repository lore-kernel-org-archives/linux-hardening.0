Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500584756CE;
	Tue,  6 Oct 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298211; cv=none; b=PaNY8FvTrbEFmYr+ax9rVO8Hz3w7MpmFEHjRqNjMGqsKCTKJFSolqYds+4kOKFGzmbtRv42+GXq/P0CJXr/a0wmW4J9OPGdcsg8hfrV0KKuDX2IWXoyC+Iov5hXF2WuzIo+u8mTnfOPHlckGrWr1plrrLuTYTR+tXvwWozwAw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298211; c=relaxed/simple;
	bh=S+ZtwArY+ICQpM7x0uJBI9Q3gewei8Gt/fd/tLBn06k=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=N/cYBQwXltg+CCsggaNIafyTxsv7AjKaIvr8CFvbN/mgz719EOjv5+hR1ZzKU93hL/A0Yxy3uE/bSQIJU4vvDZo9+ojJxJOQA55gRpNw31aP7aghHtRs9e2NqH/WZfao5kv6P4VYu741sJp4AUWvmLeS9ZmmgWxcc0xDN9gIOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=DPOwK6lw; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WTUOFuPM; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="DPOwK6lw";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WTUOFuPM"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791298187; bh=S+ZtwArY+ICQpM7x0uJBI9Q
	3gewei8Gt/fd/tLBn06k=; b=DPOwK6lwJGDEyQEYyLpL1KlJmp4TG3o6NDVH95ViHN3WSdpDk0
	IjE2NpnzDBq8FPF7pd8FlK2Wz46hiEUC0OHe8dtya6uJoe7ngfI9J0QDHeLSp3bcBoPgtVaS5mS
	1vd2Dto1APFoveJ/q4VsiY7IfZMn+lwbm+HlTAn8hRgpZu69EfONDfRl+vX/cm7KJe02aofF5hr
	yARaWJ2/I0srmkVz2baHFJcrArjN9TMggLIG8RIhbuL4Q2gjXnujqmM2bZ9WuDY3tMjwBxIBC6H
	tO5TgD/hsG1fxuHH+Ld033Lopr1RGwycaqlnazHIv41d4ZCHdda4+iEbSOzL4xbntfA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791298187; bh=S+ZtwArY+ICQpM7x0uJBI9Q
	3gewei8Gt/fd/tLBn06k=; b=WTUOFuPM6r+k/sUX1v8IvNMPYrDFDcn4amMMHl13YoeieUxjJN
	HTFr0JvoYnfolAtGwjj9z0p4TRODwk6bvmDg==;
Date: Tue, 06 Oct 2026 15:49:46 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kees@kernel.org
CC: cwang@multikernel.io, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net, wad@chromium.org
Subject: Re: [PATCH] seccomp: Document RESTART_BEFORE_RECV and O_PATH addfd
Message-ID: <17B72764-70B4-4C8B-8E67-9FF860922C89@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Looks correct, thanks

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
