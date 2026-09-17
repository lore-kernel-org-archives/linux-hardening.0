Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0F5921EA;
	Thu, 17 Sep 2026 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655073; cv=none; b=XSf9K8Wso6KSPm6V4yVfYMBWNT6fH3C8HvY6/l/eVlh2C7JZOHZEUqdHGudS64FhbfpL0eLvrfDw3qLFk+vVFHeGBGijxjj1UsVHR0/M/OoBkjwFy18DfuLwNipzcqY17Efjy4L0WVE3LHOxH3PeDB1iEkI441UxiIl2km2fOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655073; c=relaxed/simple;
	bh=JepDnajJ/W4U/PpuAGDRTUHGL//wfk7k2lcWVt5yb6k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uEldAy/CWtmq+xX9fAEy8P5H0P01gs2f2enSVBXggjqqM+MU/Svjxqeax6OGDTgEYJNOv32xyH21LKrGcuAjLV59eyGr27folzcHaFty4AZNynHI+ZOmYrJTOChqsFgTGfLV1yt1K4GF9dG9nwNqj4OTNeKkN2Kmj0ZhMN3lYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfiEg9+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfiEg9+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F541F000FF;
	Thu, 17 Sep 2026 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655071;
	bh=JepDnajJ/W4U/PpuAGDRTUHGL//wfk7k2lcWVt5yb6k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=kfiEg9+MeJtNn0q1Ll91Q6PFCn9fq1HDPUE4O8psCdV1onj+0BINLdrI7YxoGiAk1
	 rKUnffvWYdM/anMj+1Y4uvHR3cissW3tqu+6P0aXSXWOticaatHW0JIts1/xwoORTi
	 sQhDz0bUoM5PBwF6seIntDWZXCcIIKwCGGuE2vslSjx4pa7QTbrXsvLsoMukmZRAde
	 h/TEMVqCn+M4wZcmigZmXCfc7i0c81E7vjO6MTmIRoOHE+6EcdnbdD2+Rk3d7M5FOD
	 jAbgwRAvq4doghCcUxSVCung8G6vJeBYz810eET/4KcjfdXx+LeKVO8duLyGwYbKQC
	 sYDobzge8GzoQ==
Date: Thu, 17 Sep 2026 07:24:31 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_seq=5Fbuf?=
 =?US-ASCII?Q?=3A_add_seq=5Fbuf=5Fstrlen=28=29?=
 =?US-ASCII?Q?=2C_seq=5Fbuf=5Finit=5Fappend=28?=
 =?US-ASCII?Q?=29=2C_seq=5Fbuf=5Fputs=5Ftrunc=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260917011359.1585961-1-morbo@google.com>
References: <20260916222125.1259631-1-morbo@google.com> <20260917011359.1585961-1-morbo@google.com>
Message-ID: <9DA6BE5B-E65F-4E8B-8B56-A861042100E4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 16, 2026 6:13:59 PM PDT, Bill Wendling <morbo@google=2Ecom> w=
rote:
>Converting some strlcat() call sites seq_buf need behavior seq_buf
>doesn't currently provide, either directly or without introducing subtle
>bugs:

Ah, our implementations have crossed paths in flight=2E :)

> - seq_buf_strlen(): seq_buf_used() reports the full buffer size when

We agree, we need this one=2E :)


> - seq_buf_init_append(): seq_buf_init() always clears the buffer it's

Oh, nice, yeah this is cool=2E I'd like a different name that mentions "st=
r"? Maybe _from_str?

> - seq_buf_puts_trunc(): seq_buf_puts() (like seq_buf_printf() and

I prefer my solution that just truncates and sets overflow=2E Nothing i fo=
und needed the non-trunc behavior=2E

I'll send a v2 of the other series with seq_buf_init_from_str?

-Kees

--=20
Kees Cook
