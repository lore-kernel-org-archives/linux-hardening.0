Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53A40DFBA;
	Sun, 15 Mar 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583787; cv=none; b=pfRSNsXkQ7L0GduyQ7ZWYEBQ+yuUWBzb0lBZAI3PkZ5V1Zt7dGVEiw9ZQv9XvQSWvP02lfzqlMnDxCtZb5qXYXPKfFqBcLyXevwiN0uBvNPb6qUqiXmKGaXBwKcIWSdQpHsI2nbMROcMHsqhaeksLEomHnPpAmsP2piPnCi9mNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583787; c=relaxed/simple;
	bh=3ZddsW9EQIsmvEJk7cw/TBxvb69D9jBTDoi6X6sTV2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgBBapYGx62Je1PfQmbTK3XmHSFgmph734piotJKtvkUpZ6wZlSA0xyKwlFU5WffF3C0oI5Vcx35wRw0zA5ZMcE2li68zwXoXESuHpb4Q35Vv91H2Ek78BrM/fpV1e9yL9+C0Km2004ItOUm7Y7qnrpLCMLv41gt5rFoW+rsW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4A6EA1B9121;
	Sun, 15 Mar 2026 14:09:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 49AC46000D;
	Sun, 15 Mar 2026 14:09:37 +0000 (UTC)
Date: Sun, 15 Mar 2026 10:09:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Message-ID: <20260315100936.33132aab@robin>
In-Reply-To: <b88aa1bd-5b7c-a31b-fea6-3886099e2fec@igalia.com>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
	<20260313162831.32b52b6a@gandalf.local.home>
	<b88aa1bd-5b7c-a31b-fea6-3886099e2fec@igalia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kd46rmjzfth44zi66wyookoxuzcnsyjw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 49AC46000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19FG+BI62ZAn8vSZfukw4k6TP5gDZ2zDaQ=
X-HE-Tag: 1773583777-894511
X-HE-Meta: U2FsdGVkX1/alQOvZlvnVOuCHy5XM4UorPyw9SNAMKo/pUxmScAUglGHEdV0PCGkxifV5DfCtxrdRUHkEXhL2NN4y4wFXTTS59wY61cxD2mqfH9KqmhQzmKkVzcQBsQVRwMOPujFArJxX3OClPFmWEh8D+aaX0kYWOIKQSurffoEdmx6yo77mczcJ6cPyOvCQ4of4iYbNco0AhJtRJ0dhEmK6JpHRgRDQqLGxcssE0uxthkkPWtxThYrkfFIM48iLUoJ20acrVvgO+ITOsQrNSae/eOWolPtsGbGbZNJA7hEIcEktfpoT24HrQCqQ+h5qUYANwpzmam9nigATvfdubCunfnv6KoheBwWcWo5PEFpxGwq9AfoxLRjcTgviLmN

On Fri, 13 Mar 2026 17:57:35 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:


> Hi Steve, this is very interesting! Thanks for pointing that
> infrastructure. And I'm glad it confirms my impression that the full fix
> of that isn't trivial heh
> 
> So, are you suggesting to use the ftrace infrastructure in the
> pstore/ftrace? Well, seeing how mature the ftrace infra is with regards
> the persistent ring buffer, I'd say pstore/ftrace+ramoops gets useless
> now heh

The persistent ring buffer only works when the memory is reliably
consistent between soft reboots. It doesn't work for any other pstore
interface. Thus, if you can rely on normal ram being available across
reboots, then use ftrace. If not, then you have to use pstore. Hence,
it doesn't make pstore useless.

I would not use the ftrace scratchpad for pstore, as if that works,
then just use ftrace ;-)

> 
> The usage then for pstore/ftrace would be more with other backends,
> really low memory cases like ERST or UEFI, for example, in embedded
> maybe. And in this case, saving the full modules name table + offsets
> could incur some precious memory consumption and/or performance impact.
> Or maybe I'm talking nonsense and this would be quite OK ... guess worth
> taking a look.

Exactly (I wrote the above before reading this paragraph!)

-- Steve

> 
> I'll wait a bit more to see what pstore maintainers think about that, if
> is worth to have the very simple KASLR fix or a bit more engineered
> solution that factors modules as well.

