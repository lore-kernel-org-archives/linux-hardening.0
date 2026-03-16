Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614BC3321C1;
	Mon, 16 Mar 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679635; cv=pass; b=C6oCpzI7C0mLp3fNzMOhEDIKhfYFJhCaMbnyk2m8mQkWn0OxfCvgSelGQPBstylUxJz6F9qp76lXcpM8VVDPEDiHONNR/0zV3NnQedYOJZqYkhYCae9R3W+b4MzIeGq4QnD4L5Q738p80zV1oUkqB09Jn7okpzIBXHuvSBG/fOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679635; c=relaxed/simple;
	bh=QB6Nbb3K9rYmdBC/gQAXcZ4wHGwwF5GKsbACvJ6sMgQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MvTBep5gfE64HMpl6bilJw+nBe9MWmuTvxedrJIb2nERKZk1DUNMxs8ihIyXjTuYd/JVA2JuD9253i04Q+x8pQoBWNpNbPVR+Pm8CI7riMQlP7m0ZnkGufSkqy9u7hDM97VdS3hsWMCHrU2RIDSO0t5R5805EHj7nTxMyGSqhQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ltSkmAZj; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ltSkmAZj"
ARC-Seal: i=1; a=rsa-sha256; t=1773679610; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LsBUj//PmIprKO1/+ify9t1NHdN6aAeTH9Es+XZcaTm6d57D3jv6Yiog54B6E+iY7bwuBI1bQZ5VmNtTPW26qeXKtMJLw3SIZ0l9Nk7+bBAYTOYljzO8gycwArQzZa38+eSnmUphFkjvR8fZQ6IRCKZtcDsUrYa8LQCaHrIWS2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773679610; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QB6Nbb3K9rYmdBC/gQAXcZ4wHGwwF5GKsbACvJ6sMgQ=; 
	b=U+zinTkcgjOhXO8g2YGSj0b1RdCJBQSWyHbzmy6puA6wy5o6Wd91YCzXMhxjhDCQAZszTboZ5Kbfe5vXyWz3O8njpDFywFg5It5lMFQMY/2g7rOTAFK8hd+vqBpY50Y1TMhO+f0WJpn2KImvHUIP4yqo4j76VZgF0PG85vZ0wyM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773679610;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=QB6Nbb3K9rYmdBC/gQAXcZ4wHGwwF5GKsbACvJ6sMgQ=;
	b=ltSkmAZj7yNFYEI/j9+yCB/2AqZHnmc6Ql7YeLSTHwC3UUOSGBf5PAggUVcaq3qO
	KR81AybllKdVNTC0YTHkapm8L21HS4/LBnCzkTqidUOR9Z1RGyYFpG+Y2S1kFhO5RMh
	xvfgwi+hdV8E6eUG/Q7o6ggsgEzOeikz1D7DWblM=
Received: by mx.zoho.eu with SMTPS id 1773679607125882.0008909294729;
	Mon, 16 Mar 2026 17:46:47 +0100 (CET)
Date: Mon, 16 Mar 2026 16:46:47 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
User-Agent: Thunderbird for Android
In-Reply-To: <abgzILD0L2sdvAFZ@ashevche-desk.local>
References: <20260316161728.84485-1-objecting@objecting.org> <abgwF-yT_FtLTgQ3@ashevche-desk.local> <C98872ED-CE72-4201-B5A6-D5AD5EA336CF@objecting.org> <abgzILD0L2sdvAFZ@ashevche-desk.local>
Message-ID: <11CFF535-91DF-4E73-ADA8-51CD8D51FACE@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 16 March 2026 16:43:12 GMT, Andy Shevchenko <andriy=2Eshevchenko@intel=
=2Ecom> wrote:
>On Mon, Mar 16, 2026 at 04:36:40PM +0000, Josh Law wrote:
>> On 16 March 2026 16:30:15 GMT, Andy Shevchenko <andriy=2Eshevchenko@int=
el=2Ecom> wrote:
>> >On Mon, Mar 16, 2026 at 04:17:28PM +0000, Josh Law wrote:
>> >> BUG_ON() in a library function is too harsh -- it panics the kernel
>> >> when a caller passes a dest string whose length already meets or
>> >> exceeds count=2E This is a caller bug, not a reason to bring down th=
e
>> >> entire system=2E
>> >>=20
>> >> Replace with WARN_ON_ONCE() and a safe early return=2E The return va=
lue
>> >> of count signals truncation to the caller, consistent with strlcat
>> >> semantics (return >=3D count means the output was truncated)=2E
>> >>=20
>> >> This follows the guidance in include/asm-generic/bug=2Eh which
>> >> explicitly discourages BUG_ON: "Don't use BUG() or BUG_ON() unless
>> >> there's really no way out=2E"
>> >
>> >First of all, this doesn't really change much, especially if one uses
>> >panic_on_oops=2E
>> >
>> >Second, the entire function is kinda deprecated, it's better just to d=
rop it=2E
>> >
>> >$ git grep -lw strlcat | wc -l
>> >142
>> >
>> >(In reality it's less as tools and implementation are not users of it)
>> >
>> >Third, if the caller is that problematic this may lead to the serious
>> >(security) issues=2E
>> >
>> >Based on that, NAK=2E
>>=20
>> Hmm, good call, but how would I implement that? BUG_ON seems a bit too =
harsh
>> for a library function=2E
>
>Drop the function=2E Start from converting users to strscpy() or similar
>(we have a few for different cases) and then drop strlcat() all for good=
=2E
>


Okie dokie=2E I'm doing a patch on that right now, keep your eyes peeled o=
n your emails, thanks for the suggestion=20


V/R


Josh Law
