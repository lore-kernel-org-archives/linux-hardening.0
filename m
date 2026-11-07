Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019466;
	b=AKRbBcjpSo9V9wGlv/Ab5mZOXAznWkbEUB7d6tClaZCHg9ZZ0/TnodwD88DfSzH3R0Yv
	 IpLHTbbwYl8Y1OaNhLiWpKerD+Jt71xPLps9tHH5oPp7afFBYk9xeMoynzCXrgjCijHwa
	 1IlEWdisgxMW0UUDocHA9BkiCN2slz+LKsJlETJ6WlypG0SWg/9yZX1cCMTvE2dE8AfdC
	 Z6J1eiQzKEyB5/yXZXAyZKB002HFH71pT3OvaI+uVO834bDt1yUhIj0/ssurcj6PJdd5t
	 VRK5CVHQJfR9a8kx+4h/ppbl2n4ImOJr9R9HrgVNdMVT/M85+FBa8jfQrzqJU6RxelA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019466;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=wR1psqJPE2a2cMppvr2jpBghF56e6NepOoJgqMkmigs=;
	b=TWaafZAtJzTPqILYWGichiczVu4rZ1QmLeYCgyCAlvRbXgML4DU/pWfIQUNt6kKRRyz6
	 KaqvV+/R2NcFSpyrmUuuXdsiCmKYBtO9FIxaQem9yEgVyz/IfxEPvhkCJPW73esm3GpYv
	 uOov1ONhJOBQ8MTuGFnJbiCb4pB9ltnkaMynXzCqZd76i4Azjba+rlFpGWJdDb6oOWEsA
	 2OF4o74IfRUu+RyUftmGECFJFT8JVY3pu6bKb1ErTLBC4WX75ZWQdKzuSkOZM+cc3Ml6u
	 hmSWhO9LTEAgedx8ZmxGCHSp2diHIpBhwVlwnJdKGR2urJHfddrarlYgxYZJVqEdS4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE0606A326;
	Sat,  7 Nov 2026 02:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFCE0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A293C92009E; Sat,  7 Nov 2026 03:44:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9B86792009B;
	Sat,  7 Nov 2026 02:44:23 +0000 (GMT)
Date: Sat, 7 Nov 2026 02:44:23 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, alx@kernel.org, andy@kernel.org, 
    bartosz.golaszewski@oss.qualcomm.com, brgl@kernel.org, dakr@kernel.org, 
    devicetree@vger.kernel.org, djrscally@gmail.com, 
    driver-core@lists.linux.dev, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    heikki.krogerus@linux.intel.com, hverkuil-cisco@xs4all.nl, joe@perches.com, 
    johan@kernel.org, kees@kernel.org, laurent.pinchart@ideasonboard.com, 
    lenb@kernel.org, linusw@kernel.org, linux-acpi@vger.kernel.org, 
    linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
    linux-kernel@vger.kernel.org, namhyung@kernel.org, rafael@kernel.org, 
    robh@kernel.org, rostedt@goodmis.org, sakari.ailus@linux.intel.com, 
    saravanak@kernel.org, schwab@linux-m68k.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
In-Reply-To: <aux8LYQkGSNjCGHv@devuan>
Message-ID: <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org> <20261105125154.83478-1-geert@linux-m68k.org> <aux8LYQkGSNjCGHv@devuan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Nov 2026, Alejandro Colomar wrote:

> Do you think strafterprefix() would be better?  Do you have any other
> suggestions?

 FWIW strsuffix() seems an obvious choice to me.  After all what the API 
does is request the string's suffix beyond the specified leading part.

  Maciej
