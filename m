Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331848D87C;
	Fri, 14 Aug 2026 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734544; cv=none; b=h5IbhnEnt0IOSgkaDIAJh4M9iMVCpltNB9obdLu9T9shB1sQZAFGsJNFZ8pnu9/jheU2tf39C26FCGXA5PYe64FTeXRd9SVUYp189DiQE2lQ3/VUiRXiehYp14LxIzPRvGQxiMtVcJb1JP8Byd4E25SCc0+nQ8gdyIIedY+puWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734544; c=relaxed/simple;
	bh=Urd6fhjEJMW8hvl4We+DDMpWIXnt0w2MbMkWbmjhiVs=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tXQhzleCpBTWsY0EmMKgQQlt18pdfj+285NBjQcgM2orYL+NHCepovbO+HhuKo54dwgxVDhm1xtApjxb+ZlNkacIrD4jbOw3g3S69xL8LGuH9aZ1WF7YQXKAau0Koq2IHdgFeJGD+UsnfU3XG1SbKXS+gGzTOISPEjPF+3FkOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=kmXJBGFx; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="kmXJBGFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786734532;
	bh=Urd6fhjEJMW8hvl4We+DDMpWIXnt0w2MbMkWbmjhiVs=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=kmXJBGFxDO9ZjanykO5DzKxjAyj8o5WTRlReDkgG30mRPYPGJbFeLlvrKvEo4HUsg
	 /Y4imeOIu58hdxkcRAlhvXVTmelr+i9xSbKl9SLbe1Nn11nmEB2f0IwAz+RAblb916
	 hnSmpEBsKYghvc/+JHWbEdVtnLm1DWG5W1TZ0r2Q=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hMBbS1SRPzGp94;
	Fri, 14 Aug 2026 19:08:52 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hMBbR6NZgzGp92;
	Fri, 14 Aug 2026 19:08:51 +0000 (UTC)
Date: Fri, 14 Aug 2026 20:08:53 +0100
From: Bradley Morgan <include@grrlz.net>
To: bigeasy@linutronix.de
CC: akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com, kees@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@rasmusvillemoes.dk, namhyung@kernel.org, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org, tycho@tycho.pizza
Subject: Re: [PATCH 2/2] kallsyms: Don't leak pointers for unresolved symbols.
In-Reply-To: <20260814144854.746840-3-bigeasy@linutronix.de>
Message-ID: <6A4A7DD4-1B62-4618-A1FE-358A51014611@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

LGTM,

Reviewed-by: Bradley Morgan <include@grrlz.net> # kernel/
Thanks!
