Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE09286A4;
	Sun, 27 Sep 2026 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790473703; cv=none; b=cFwsopuH25boPkkMf+7pnEpvEbVNjSeDeCCSgeMPd6KUJKe+EDR7/rb07pxexdBmUMkqMBC1aPoYkKsfY+NdYDvy1enpcghsW8DDyMVQ7gdBVxm0RhJUXa6VdhiAJVDl9tfWLEBBvg8sPIKfFSWbD45SRTp1sTxEqnfx3E6qRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790473703; c=relaxed/simple;
	bh=AjF81T39KEvWhZMb55n0e4H+RSfysG7EYcFp/wy6LiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak0rePyNFY3+v0VGCUV5FTqL0+q6/6QNuEgVSJGjEmyhKF2ZVTrd35yOCqwWOnOILffFin/XseR6LjkMxavf1hpbhSD08ImeuSd6wPjphI1LXwi+aLCfZcMlvg8YH/GegcqKFLnoeINlG5/L7XFvF7Qg0RmCjWLt5ksa5zwaAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=5utP4Ply; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xGQcNlfW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="5utP4Ply";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xGQcNlfW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 670391D00073;
	Sat, 26 Sep 2026 21:48:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 26 Sep 2026 21:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790473701; x=
	1790560101; bh=PZ4zM8dBttNCoyc/5E3e2jTUTQxLhBIaPaJqr1Ygukg=; b=5
	utP4Ply1JOzOrvOiE6sKhHPkoNsJolczum3jm3WajnMJz8G8HBvjsjlFsFejHjHO
	/k03op9OK1yM2ZLLGBgiuGW24VOU22MwW4j0Nygt7IPU1ZfVhTew9HQ5GQnb4tqY
	BGNFhS/Gs+fMlAQqBlHNTjLqMgkP0pt9TPSkMqXZi0Zg1x2Cz5Im/7YRUjODSTXd
	TvUNHy2qxqmxRfL8j+sAHv6CxKyYVLMBXBOh+ArPJ3eOM0Qd5YgOk2DBNfbCrMwQ
	PtiutKYOkpK2Qj4hUu+BE7hMcyOAoYqFTjD8UEcsVdTpq0oN7QetWKkuFAYZeAh8
	aVO+k8/wWnY1nW1qBI9Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790473701; x=1790560101; bh=PZ4zM8dBttNCoyc/5E3e2jTUTQxLhBIaPaJ
	qr1Ygukg=; b=xGQcNlfW+e2UNSBRVQXWWuy4xlnq75RnegNxxwR/xPLpDZLtqg5
	ihBjZo4YHLRUNUKy3yT9JCOvmdcnPYXDQkuEkjhwKzDr0dr6IcsdA6kUZzn2YYsd
	zKdkmOC/uxyvILOernlfmrjrqORjpW2mwx36K4LlnzggE1J7iNArHcXSGNjQ7Hdu
	pe8I+O+PG7QJxvCBPD+eXn+XOb8PpPhH85lkVJBM9PsTRamptN/4AxRM4IrQ65Xl
	w09ZgFt5372suwpt06xcsTfIL8Enahjk7qaFA3d+wqMvHzARZ2Y1oJmajEGYFD6B
	GTiqDtmcGgTHNptelL2Mo5+nuPsCtmFm08A==
X-ME-Sender: <xms:5XW4apqpyaFXFdqmIjzwW_7MKc9vjEAWdz6wwQ0MKuUK2z2v3fv9fw>
    <xme:5XW4alvygklJ-p_c0dukwQj4LSPhMdnDOdsf6ilv0wJwTtqpcE4XNnGQNJmLvE70a
    SQLuOR05PSQ5yH8GPzLXR8yX1SGS8FXUngS-0u28azHbYiyc1_oBUKC>
X-ME-Received: <xmr:5XW4amFOPbygAaM22IevJd71xZ48NE76yGQKNoJs2G3bN0Yq1f6cpNPlUelDweXmJRCnr9dnX88nG2Ug_p84FsoUPDNYbQ>
X-ME-Proxy-Cause: dmFkZTEdcxc8kt02CLiTaT/9YI+yINJTzhEM3LUFehMhj4KVXjZyWu3TjzUTW1CM9QpXy+
    nlPlhwUiBgfOmDPKnL809Dc3tidtL3oBD6XCrMzuBUzsx9HAMCmrGTAghxiJf15DH2QvLB
    mjRosHRKpFbYyIWZRi5le1IA3/t+mbC5IujIr9RneWhyUB4a6jUhMOE54QRTTIW4pcQ2It
    PLiB2yGjR7D/RkIt+CDz46TWqg3CZOzdwcQTkwUG75JcxYChZ6D+heEJEGZqvAbbybXVSC
    vbUm1ovYYUFoknZUu0k0ZBQAme55qZrbZq704VEqlUptRYpQWvhiftOnwvck1v03MerZDv
    b8O7FOT1cy2Odhanvd3+VFFg/n/hoKSu1RJo0qofjRhpu+yzw6M1OCgmmi/jA+VLHGnGK4
    knp/NRGJREyErBUHMwtbCWG7sYrLrzOvARsldpYwXQwsHErNXpOenHWiXY0lsOaDKOTnrn
    2sVVbmH/EGw9FMTBGs3u719CQqzEgTAR+eFL4visOUnoL2AeeVxgv6Nyq1hsuRpFVm79xw
    sWBcRBjmr/3cFUpVaOBUtNnZ2YzI09jBB43pGkpz3KRnVyFZUo2IUxh/pYNNkI0oYDQrsT
    mkKi6iMDnSgajqZMirn45W9pAezmXQdvvmoEPvPyRsogQPc4B/km87Qi1TIw
X-ME-Proxy: <xmx:5XW4amaAWiiWbbw5OLxYzz79AqfGQvnD2fauqwcoZt_6watQiOKr4Q>
    <xmx:5XW4amUNeeMWdk2g63nBLjrBao8tlH29hkWS9FzLDD55a5YcnSJ_Cg>
    <xmx:5XW4asmPmADCqOSZAEZjQK88Ejl6Zh85-IIxBdlbfXdQuaB4VDpO0w>
    <xmx:5XW4ahBdrlWo-BprDfnIkLigUnF8fW9aWbwYblUlGfKA3wNgaOJO8Q>
    <xmx:5XW4ak4CkVy-D9LWqm9vw0xpw0dc1at1WWXptK02V5Sn9icOxj85A4c_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 21:48:19 -0400 (EDT)
Date: Sun, 27 Sep 2026 10:48:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] firewire: core: add __counted_by_ptr to struct fw_packet
Message-ID: <20260927014817.GB9201@sakamocchi.jp>
Mail-Followup-To: Bill Wendling <morbo@google.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	codemender-patching+linux@google.com
References: <20260925210912.113052-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925210912.113052-1-morbo@google.com>

On Fri, Sep 25, 2026 at 09:09:12PM +0000, Bill Wendling wrote:
> In 'struct fw_packet', the 'payload' field points to a buffer of size
> 'payload_length' bytes. To enable compiler bounds checking (via KASAN
> and __builtin_dynamic_object_size), add the '__counted_by_ptr' attribute
> to the 'payload' pointer, associated with the 'payload_length' count.
> 
> A thorough analysis of all allocation and initialization points for
> 'struct fw_packet' was conducted. The pointer and its length are
> assigned together.
> 
> Because the count field is always correctly initialized before the
> pointer is accessed, the '__counted_by_ptr' attribute is fully safe and
> will not cause runtime false positives or panics.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  include/linux/firewire.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next branch.


Thanks

Takashi Sakamoto
