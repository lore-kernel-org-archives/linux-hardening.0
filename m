Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2329BDA6
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935880; cv=none; b=tZBWOo2boc1etmN49hZEspKJ8gnO+e1EVciqehHHYIArwUEDmd0DjbOGsbFCek/PetGdPbZk3QgwUutym8bcO3K6c5HX8dwiDXqs6S3kycy6PJ9fmDl7moiZ7+OIQ+0HBG/pU2tdox3eN1BwXx/KvxoVNSfm/HRbjo9tGC30Vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935880; c=relaxed/simple;
	bh=62O+UBIpCiRijKTrR0BihJr6uwaWc5eliD3lbpm91Lo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OF6RmGAi7amXlfs4+3ZCrlJ1BOwT1yHO4dH2O4yNKzvyBGuvImIuRG1ArM3EIyeTvj96pnNJ9ilhi6tCxrrE3ihNpXWdsHKQp/EwSJQP7fAog86RtxZPXj32joFkkJIAfbKQba+osS7U/Pn8HCdkArDN7wuC43AeKJLN73dnkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEOB7j2X; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEOB7j2X"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754935875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62O+UBIpCiRijKTrR0BihJr6uwaWc5eliD3lbpm91Lo=;
	b=VEOB7j2XMj/HkOQ3JmkWEGtRdK6BNwegf5QuTu9TV6BkyXCQZznus0J93V66rIP9AQrMtO
	4CSHznEQ/yOG01H4stpraqgEbvzTgxrXTZWjvebgQ7YHR/QNlqQ7Fr/+/7evZ1sUO9o1qQ
	GH6Fyu59s/RGrCFU6bWuq1i/l4mr5w8=
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
In-Reply-To: <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
Date: Mon, 11 Aug 2025 20:10:58 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org,
 Daniel Thompson <daniel@riscstar.com>,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
 <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

Hi Doug,

On 11. Aug 2025, at 19:48, Doug Anderson wrote:
> On Mon, Aug 11, 2025 at 10:04=E2=80=AFAM Thorsten Blum wrote:
>>=20
>> strcpy() is deprecated; use strscpy() instead.
>>=20
>> Use the return value of strscpy() instead of calling strlen() again.
>>=20
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>=20
> It made me a little nervous that you're not checking for the fact that
> strscpy() could return an error code. Without the check you're just
> replacing one type of problem (buffer overflow) with another type (the
> code running with a negative length). IMO in cases like this either
> leave the strlen() in there or check the return value for errors.

Yes, I should have checked the return value or left strlen() as is. This
was actually a last minute "improvement" I should have skipped.

> ...so I looked a little deeper here to see if the buffer overflow was
> actually possible to begin with. Looking, I _think_ this is true:
>=20
> * `cp` is a pointer into `kdb_buffer` (location of first '\n')
> * `cphold` and `cp` are equal at this point.
>=20
> ...so you're guaranteed not to overflow because the destination and
> source overlap. ...but that means we shouldn't have been using
> strcpy() either way. Both strcpy() and strscpy() say that their
> behaviors are undefined if the src/dest overlap. This means that
> really the right fix is to use memmove().

Good catch. I read about the undefined behavior in the function comment,
but never encountered it and haven't really been looking out for it.

> The above is based solely on code inspection w/ no testing. If I got
> it wrong, let me know.

Yes, I just compile-tested it as I didn't expect src/dst to overlap. And
then my last-minute change to strlen() made it even worse. Sorry about
that.

Are you going to fix it using memmove() or should I submit a v2?

Thanks,
Thorsten

