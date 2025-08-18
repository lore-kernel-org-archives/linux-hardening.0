Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C21FBCB2;
	Mon, 18 Aug 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550792; cv=none; b=eyuSvZfpGJ767JVzr2e7clQHnnSFSOsd3UfdTu40/Bx85r8IL45VyqhVsmOw50X8xrBkVQkU5y4uQ+wCVStDXIqs/6tHrLFqGownb2WXHjefa62jAlLZVvGgKR0bsiGj50UU2+d8jTqX3h7luMVe6eESsBG5vKxbAOStrgQj8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550792; c=relaxed/simple;
	bh=BTDLB1c4YWuP7ypwEDVl5hczsMlu/uvmqdjn4I5F7Ao=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WPYD9QOBoHBjcD7m/nkGpx4pGBTrh06GJ1gnrNfAMxqebdekF2b3rk+Twyn0saQY3+e14vAwcXX3ucJ/bAfyHt0wQ8T3xrpbVSqe17+K/3Y5bjwoxgnJxLjFJR/4XtF4xFkrwjBv9F8sgMGoUlARz0KWE93ClIQv9MA62h4wLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JNzFI0tu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JNzFI0tu"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755550789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9s14oyC6Y23cr8qVEDnKGPSBJDMao28DU8LVQLQXYK8=;
	b=JNzFI0tuE0B6jJZzVzll5qsMZUi7ooiEWkuE9Vz4SbhjNbU9LcK9ygd4PPgX8KtKqFWtNZ
	DEfEZ3pGja9GxEc+rS76JRVWks765CRD4fxI+jpMe14J+siqv31euCUSghCm6eS7b8c0m0
	z9V3zT90toqVr9Lr+r8wye0HBDQySdc=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 4/4] kdb: Replace deprecated strcpy() with helper function
 in kdb_defcmd()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAD=FV=UhEeZdCwL0kVmDHZF03q+Jp5iOiUvbNNoCDuBr3os9qQ@mail.gmail.com>
Date: Mon, 18 Aug 2025 22:59:35 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Nir Lichtman <nir@lichtman.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhang Heng <zhangheng@kylinos.cn>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <33D2B62D-9052-42A8-AB66-DF2903BBA52F@linux.dev>
References: <20250818181153.661431-1-thorsten.blum@linux.dev>
 <20250818181153.661431-4-thorsten.blum@linux.dev>
 <CAD=FV=UhEeZdCwL0kVmDHZF03q+Jp5iOiUvbNNoCDuBr3os9qQ@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

On 18. Aug 2025, at 22:42, Doug Anderson wrote:
>> +	memcpy(s, str, len);
>> +	s[len - 1] = '\0';
> 
> Very nitty, but technically the above memcpy() could pass "len - 1", right?

Ah yes, I missed this after adding the manual NUL-termination.

I'll send a v2 tomorrow.

> It doesn't really matter other than the wasteful copy of 1-byte, so:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Thorsten

