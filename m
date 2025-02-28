Received: from cygnus.enyo.de (cygnus.enyo.de [79.140.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2D26BD95;
	Fri, 28 Feb 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.140.189.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744797; cv=none; b=Cx6UeqlOI+zV3XUvjD181BtEDzIikd9btSk/FTtbqf1hRo3xdsRoZSGEoRhlZbwqaLF/L8jAt4L0aumhZoqqu8CyLhb4RE7wuZLDmEeGSqaIdlpzxpA9HQZZgq0qm77dP9Ppn0Bbk3yhhRFMH0nciclVETNXkkLRtlH2/RxzEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744797; c=relaxed/simple;
	bh=1McGrNBbDrYtzgnXDVh3MFIIYbp00fEFjuCIx+7ZJvM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YEBbCVYpElCYpESBsVUq0Xl2NYW57GEo8Uo6fcNNOq4JBG/ibfICgJxAEFR1mzMX7v1k3h8cLh+XxfkyPg1nvxYeF7UZ5E4bcCcA7ujVGov26+FHbv4TFnQjHKTeopCwJzDuCrsNloKos2vJ6sRhTSGvcgMCvtfZofCUEye7CAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de; spf=pass smtp.mailfrom=deneb.enyo.de; arc=none smtp.client-ip=79.140.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deneb.enyo.de
Received: from [172.17.203.2] (port=54045 helo=deneb.enyo.de)
	by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1tnzEl-0099KG-1o;
	Fri, 28 Feb 2025 12:13:03 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.96)
	(envelope-from <fw@deneb.enyo.de>)
	id 1tnzEl-000FoQ-1N;
	Fri, 28 Feb 2025 13:13:03 +0100
From: Florian Weimer <fw@deneb.enyo.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Jann Horn <jannh@google.com>,  jmill@asu.edu,  joao@overdrivepizza.com,
  kees@kernel.org,  linux-hardening@vger.kernel.org,
  linux-kernel@vger.kernel.org,  luto@kernel.org,  samitolvanen@google.com,
  "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
	<c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
	<CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
	<1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
Date: Fri, 28 Feb 2025 13:13:03 +0100
In-Reply-To: <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com> (Andrew
	Cooper's message of "Thu, 13 Feb 2025 02:42:10 +0000")
Message-ID: <8734fyqncg.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

* Andrew Cooper:

> The SYSCALL behaviour TLDR is:
>
> =A0=A0=A0 %rcx =3D %rip
> =A0=A0=A0 %r11 =3D %eflags
> =A0=A0=A0 %cs =3D fixed attr
> =A0=A0=A0 %ss =3D fixed attr
> =A0=A0=A0 %rip =3D MSR_LSTAR
>
> which means that %rcx (old rip) is the only piece of state which
> userspace can't feasibly forge (and therefore could distinguish a
> SYSCALL from user vs kernel mode), yet if we're talking about a JOP
> chain to get here, then %rcx is under attacker control too.

Will the syscall handler do anything useful if called with an invalid
system call number?

If not, and if you can changed the FineIBT cookie register to %rax,
would that address this particular gap?  As long as the cookies do not
overlap with valid system call numbers?
