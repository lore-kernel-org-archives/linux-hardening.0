Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E850167D80;
	Thu, 24 Oct 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812705; cv=none; b=dwiL1pJmWGQ2X8j0bHVsStRYOlZhz6F4s3GBzGW2JqAjNmkRq3ASYVW0VWfm8fq03XAQrWGFKKyVziSjBOLkKBRzWVGUbBmilA1zI188L4/v4uRNfhxQZqnz187X7ye5wtAz3kTz27PXtYvZxiLiWCVaT2pCsh9qoLOG/xUSJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812705; c=relaxed/simple;
	bh=kQ3TS37HNvtEvnoAtceyGXajlwnRdZkTgCWGGvRL1Kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A+XTyXgvavQo0tSeE4/5irEehRldhusYS/A+fCEuikDVezFYgdM8vFIpsxyOXXH8ytSVzipd4VZW1hM1Hq1cYYZIk0LYrPesGPvEH/0NDmI3N0IODoHC/2UGwU2Q7LGBb/uPtAkfS6zfYuDwBT//wKuLaGL9zPktzrNv2oO8k+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1E23292009C; Fri, 25 Oct 2024 01:22:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1C0ED92009B;
	Fri, 25 Oct 2024 00:22:02 +0100 (BST)
Date: Fri, 25 Oct 2024 00:22:02 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, bvanassche@acm.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ricardo@marliere.net, 
    zhanggenjian@kylinos.cn, linux-mips@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] mips: sgi-ip22: Replace "s[n]?printf" with
 sysfs_emit in sysfs callbacks
In-Reply-To: <ZxDVRru_o_5nqGl5@mail.google.com>
Message-ID: <alpine.DEB.2.21.2410250019430.40463@angie.orcam.me.uk>
References: <ZxDVRru_o_5nqGl5@mail.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Oct 2024, Paulo Miguel Almeida wrote:

> Replace open-coded pieces with sysfs_emit() helper in sysfs .show()
> callbacks.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
> - v2: amend commit message (Req: Maciej W. Rozycki)
> - v1: https://lore.kernel.org/lkml/Zw2GRQkbx8Z8DlcS@mail.google.com/
> ---

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

 Thank you for this update.

  Maciej
