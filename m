Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B542F90EA
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254910; cv=none; b=QBGK4KFzCnq+64FMxovtnjBulnIut/QueTCNANGiWn9KobWaF7a7gW80Tnuq2A5lH9347upwl6cBUY03wQeERFyDAbap2TbvL+jFuTPWjWWAfYg56jBBuNjVi4MVF/XJgo60N50uc84rUkz1tdPNIpBPJXQn5H4NvTGaaNRLOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254910; c=relaxed/simple;
	bh=RJu/sNUIv8XQfDSHQySP+VYb7RjTMwaetdYaK/UPq6U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K4BiNXjVh/v9+wdjhNTXUs+SUE0XXRiwnjgz9Mnk1Yh1ENN9+hSBoFHB/6mEZjH/K5XyjqCZAB6ecMokOHKIEuRMFj+nI785TFy3FDWxznynWl02e/OApWPEupM5j8ffAidz/a4LBqFb+/wXVxKs7hO7eWxnUbSA5UHIQUYknBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfPOM09X; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfPOM09X"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755254896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaSW/iwCuCeSk0qdAIyHg2YdKiOz+eJwbEC+JwzC1eA=;
	b=YfPOM09XPo1BU+oBnOV3ID7DL0F8FnzVL3RMOFLtqj21U19HXwnZY8KFOUVHOMGUfAl5R0
	8+YOoU/zvn2CHEU2EX5fkIO1C4fqTfaoM7SeT4oky+Ar/RYCAKAxfVUqOFagng5rDH2mF8
	9op5kavoHOpYOXm5SI0rRRMAXalkwGY=
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
In-Reply-To: <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
Date: Fri, 15 Aug 2025 12:48:02 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Nir Lichtman <nir@lichtman.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0BB3AC5A-5B9B-4149-90CA-80171B8B0A48@linux.dev>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

Hi Doug,

On 15. Aug 2025, at 04:05, Doug Anderson wrote:
> Let's think about some test cases...
> 
> Old code:
> mp->usage = kdb_strdup(argv[2], GFP_KDB);
> if (mp->usage[0] == '"') {
>  strcpy(mp->usage, argv[2]+1);
>  mp->usage[strlen(mp->usage)-1] = '\0';
> }
> 
> New code:
> mp->usage = kdb_strdup(argv[2], GFP_KDB);
> if (mp->usage[0] == '"')
>  strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> 
> Example string: argv[2] = "\"xyz\""
> 
> Old:
>  mp->usage = strdup("\"xyz\"")
>  mp->usage becomes "xyz\""
>  mp->usage becomes "xyz"
> 
> New:
>  mp->usage = strdup("\"xyz\"")
>  mp->usage becomes "xyz\""
>  mp->usage doesn't change (!)
> 
> To match old behavior, I think you'd need "strlen(argv[2]) - 2", right?

No, it should be "strlen(argv[2]) - 1" to match the old behavior.

In the new code, there are only two steps instead of three.

With your example source string "\"xyz\"" in argv[2]:

	strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1)

evaluates to:

	strscpy(mp->usage, "xyz\"", strlen("\"xyz\"") - 1)

strlen("\"xyz\"") is 5, so this becomes:

	strscpy(mp->usage, "xyz\"", 4)

Unlike strcpy(), strscpy() copies at most 'size - 1' characters and then
appends a NUL terminator. In the example, it copies only the first three
bytes (xyz) and then appends a NUL terminator, effectively replacing the
trailing quote. The result is "xyz", the same as before.

Thanks,
Thorsten

