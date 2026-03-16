Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13761335571;
	Mon, 16 Mar 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679960; cv=pass; b=AhMMt1/SSivkq8Pszx+razDoB2DYqrmnl+rodL+7H/UTzOJE8835bLiVHyKEVgxJVsdxXqgK2fbCrS8/Nxs43ANnsyRFmMjwD9Xnzabe8mYiUeMupOTBKHqFO5klHu6R4TgL7GN1+QbqdolnqDo6obdrnOWfPYBPmnFAgLsO/5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679960; c=relaxed/simple;
	bh=acp6vhHXh8icSpbFaf+1l9dFxGutFHGvuUzAWNrUadc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sN5wPqPVvFq2QhddUb/afZScxRJuV9tAb0sAxMT5M4Ij6zG7Q1mn5Do/T/+g6+jb7aBoolMu51vO0wy0a2xzKrrddB6hAjInkq51dBPsAJVcNOqN1zYjnoW7svjh21hZSz1mrSWVSgFMFsN6N+W9iwmyVF3jNqz6CDx57IVlAGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=XjHA6Rsu; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="XjHA6Rsu"
ARC-Seal: i=1; a=rsa-sha256; t=1773679943; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dBdvDCDPh9F4tYgCneA2K+YIZQbSsgOtnC3DD7H5wU80MwB/s51eUpt11gIjl9toh53KwkgzAZnRPuNjK0Ds015C6vmhJ3h2mNQAxrsl1OtnSzjkId8GP2IAAyiraH1MUkgLY4gtMtxORJglxaDLnlU11LRfcaleSErOkU82DDc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773679943; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=acp6vhHXh8icSpbFaf+1l9dFxGutFHGvuUzAWNrUadc=; 
	b=BB+bJvrqdnlk8Y/Xh/UQnc2EkJQXj0/i3ABo0ZrjAN/ByZlBn10QgdE62C6Eg6o5q/pYdZYvKl8N29EvHQWxuGN0WuB/AqMQNKeRIE/mbVBlpkNbaqGo2Q2+oAWshyn9R4pCNKsHJ1/nRCA0QU1KeD2/TL22YBvO987wYqGps3g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773679943;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=acp6vhHXh8icSpbFaf+1l9dFxGutFHGvuUzAWNrUadc=;
	b=XjHA6Rsu3jW/B6ev9fFWIZe+TKdyEwYXWyyQtJyGU13FRFxNKLWJ9EW80QNuQP+I
	V2GhItUfyYyNNkTYawMf7nHOVkm8jV1WQWoUsCGBNe9VefVj6HlX5vOtaZwNF1Z8jJW
	/KiV0aXw6bG7pByye6FLUzL7mey4LWCYZOs+lbVI=
Received: by mx.zoho.eu with SMTPS id 1773679939583770.5722276316869;
	Mon, 16 Mar 2026 17:52:19 +0100 (CET)
Date: Mon, 16 Mar 2026 16:52:19 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
User-Agent: Thunderbird for Android
In-Reply-To: <abg1G8UodaBu47Pl@ashevche-desk.local>
References: <20260316161728.84485-1-objecting@objecting.org> <abgwF-yT_FtLTgQ3@ashevche-desk.local> <C98872ED-CE72-4201-B5A6-D5AD5EA336CF@objecting.org> <abgzILD0L2sdvAFZ@ashevche-desk.local> <11CFF535-91DF-4E73-ADA8-51CD8D51FACE@objecting.org> <abg1G8UodaBu47Pl@ashevche-desk.local>
Message-ID: <86D1BF2A-910C-42F4-8569-BDB970F8F213@objecting.org>
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



On 16 March 2026 16:51:39 GMT, Andy Shevchenko <andriy=2Eshevchenko@intel=
=2Ecom> wrote:
>On Mon, Mar 16, 2026 at 04:46:47PM +0000, Josh Law wrote:
>> On 16 March 2026 16:43:12 GMT, Andy Shevchenko <andriy=2Eshevchenko@int=
el=2Ecom> wrote:
>> >On Mon, Mar 16, 2026 at 04:36:40PM +0000, Josh Law wrote:
>
>=2E=2E=2E
>
>> >Drop the function=2E Start from converting users to strscpy() or simil=
ar
>> >(we have a few for different cases) and then drop strlcat() all for go=
od=2E
>>=20
>> Okie dokie=2E I'm doing a patch on that right now, keep your eyes peele=
d on
>> your emails, thanks for the suggestion=20
>
>I'm taking my breath!
>


It's been sent!

V/R


Josh Law
