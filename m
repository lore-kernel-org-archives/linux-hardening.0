Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7B33B6DF;
	Wed, 15 Jul 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132725; cv=none; b=G/qMNZ2oLTqka/bx9KS0nmQVTOzPsJR8LXsRuF9g1CtdYk3A65Zd2iDOznVpBs4lizgi6tn++iQ4v/FJIAYvEIUNs/52EOc/vvaplIhoYoUeOZr/gpXwxU7Fp48Wtt8FROgQrrD/BZLcnZNv9e13esTwy4EMVsUunjvZUjw5x1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132725; c=relaxed/simple;
	bh=poKWUeygizp1EO87HlA7fIgB2RlWi/hBXY8bOmSIZOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhIPts0K23u0DJNQb7trLBiG6CWZDbOul6otJps7zQ5THcHMVwFgx0T3OIY+h+lsHkDYojCqOOv2SXELyNDAG0ATUX52pUPMx+inAAT794u0Tq464+icbBkeEkQk0BYUF6vANwXTZ4bmB5zlMZvkVDSpAD2rfadthfGMpTu+aZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=i/PVlCU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFtsIMsa; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="i/PVlCU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFtsIMsa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02EEB7A006B;
	Wed, 15 Jul 2026 12:25:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jul 2026 12:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784132721; x=1784219121; bh=u6yojInnO5
	u3GW2FM0QUhkIbWOfCitibGPqpyPsWV7Y=; b=i/PVlCU0l1ytNhUubkflj3j2x+
	FtlqoM6tPnRAsvwiq1GPpiGWKYw4FC9ctm4O2r7WuCpfoy8qHcnNblP6Ptj876wr
	374XrcgmU0ku2hNE3+nUryeSevmamS05QsblaqLzI6DtKcqWG1FmhEvfNnH646BZ
	h4wgWHNNntsCign4KB9MWq0I3SQYTCF/UJwDrBVPIAbA2jZNpnPPK/VlLWLhO4TT
	XwREgZI6KjjX2PDUrwuxGMN/+IbW3dO4Ijn7SOSBFlBZGwQmeLfSSr0PevBkVU//
	YPt12diPfD0256whgTGepR7LjWPjRMPfjxfteyAZ5AbLSFs1/b02gWYHvHxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784132721; x=1784219121; bh=u6yojInnO5u3GW2FM0QUhkIbWOfCitibGPq
	pyPsWV7Y=; b=TFtsIMsaGI2J3IV8jR0Jy56jIk6EIhxbOTv+FCQjVieP91tBf+v
	VHJrng+hFb/sG07HJPWrBs8NcEb3Clfaa7npVNGjIBEijIUSC7nPaB9ydbUQIx/t
	yRU3crTHD3ElSWSgeFRo56ebYRDOLH8pSL9TLuId6WlOUSFlobc9BK/3KBAQ5TB+
	HXUXtpzJm4YSRXzNON2TP32IqALnxwonRjNZHTJ5vehWQvXFK/PI0QgYVauT2Vya
	X5QExSupNRbd8Djk81q2CUD0xfg5/Bwwkmx2BT6dxtZvDhC8zJjm8w9ysf1hoD8k
	OjDNt6SF5f7TkxzFE215C+SUnjt673h1ynw==
X-ME-Sender: <xms:cbRXamR4DL5uzulXk9cTomKUq0XBYO1T9KC0E7z-w-_q_NI659RG9w>
    <xme:cbRXal169iWECJlUMltZ_J0_nMzG8NosSd0i3jGZOrRS2YIHZe1xaPHOK5-zqK363
    Syw8PpPyIv3TRz0u_oWQeyE5QKHnRNWUQtiYsvwQcWc9lWImJdX1w>
X-ME-Received: <xmr:cbRXajsDeIPSKKl_zWafsZOa83-8uicKQkYyhDTtlnsBPX_nMTDOqchily8>
X-ME-Proxy-Cause: dmFkZTGLTUfd3jhR2Xymp/5c2d3b4q74l5xjqDUO8jPmjmE5kQH2i/2TQrcR37oG10rzz+
    aBRVIVAxMEbH29yeP9cJVMd0FgVL36s9rY2m+uKM3GXp6arzSxFGezlkIV6q09NUyEhtjo
    4xk9WSLgnMYHNh8D5Y3n5qQ62CcNQrpYz7IBQFNriRgWk/WpWkTZaS8rMKOojwfepf58nd
    izHik1hF/JBOV/eBvqGu+ltPxNfLnHTeqqrwA3qdWupmb7DniUASKgciy8RmrxPYcdJ4Kr
    d7bXQs3y8klCksv9EYBO9pQPkdt+79kw1PO/Nps08xVDgyvmHhVyAb1oDgbACbdhAXQCC1
    Qld2Qheo3KWJ7F2SMwV1C6xccGume9uLIRXnWyiYFEP+FdOkeO739/3qUE4yIqCYPhWuHB
    91Co+ezAQmtR0V2ZRDQIuIHayvHurCsvowYnDU2yar1hqlmuO2CQITxS09WRNnF81lHNe9
    3MRDBPpY/svnFHyIC6V08EVeyUjklq8+Up3fIwLjZHE6ANJA/jyD8B7yn/TkpS1bYp8Y6b
    AS1AxOlIMAvAo8CSiMt71AZ25253x2Gl+TSj3ELDfeYFJsWaDT7Q0wPMVwNPgs5gr+rw5l
    eq7ezVGwMZi5OLWhQZpv9okYScXFSWpDKyJ6dzBiRvjNts7PrlfWct8B6UDw
X-ME-Proxy: <xmx:cbRXajhdzX_T_GHph-k0GH57vcKfPdq8PkN4DJ6i5_RYE09hMuA7LQ>
    <xmx:cbRXas--Xf9wmKRh4qD776enGyiDCatkulR3PIYwSdRtSRPtqspnfg>
    <xmx:cbRXautVFdK6kVe9bNUgDMfJIKU4wjTx4uQ3JsXEZKKSomftFwgOTg>
    <xmx:cbRXaopFKcUp7EV7ILwBg8dwR5Md_dVv0LcvBh9QDcDP7y4L8obvJA>
    <xmx:cbRXakPui42dNzqWWRCSuVKeW7d2uQfEsneVAtveahsBQJiksYz3qS_S>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 12:25:20 -0400 (EDT)
Date: Wed, 15 Jul 2026 11:25:18 -0500
From: Ian Bridges <icb@fastmail.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kees@kernel.org
Subject: Re: [PATCH] ALSA: hda/generic: Replace strlcat() with strscpy()
Message-ID: <ale0bq8DSefjWC3P@dev>
References: <alaPxW5S5PT_-kZi@dev>
 <87o6g8y9f3.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6g8y9f3.wl-tiwai@suse.de>

On Wed, Jul 15, 2026 at 09:54:56AM +0200, Takashi Iwai wrote:
> On Tue, 14 Jul 2026 21:36:37 +0200,
> Ian Bridges wrote:
> > 
> > In preparation for removing the strlcat() API[1], replace its two
> > uses in the generic parser.
> > 
> > Both call sites append one suffix to a string that the function has
> > already bounded to the buffer size. A strscpy() anchored at the
> > current end of the string writes the same bytes, including when the
> > suffix is truncated.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Ian Bridges <icb@fastmail.org>
> > ---
> > The patch was tested as follows.
> > 
> > - W=1 build of sound/hda/, zero warnings.
> > - A userspace differential harness compiled the old and the new
> >   functions side by side. The buffers were byte identical over their
> >   full length, including the bytes after the terminator.
> > - A QEMU runtime compare. A guest with an emulated HDA codec was
> >   booted on the base and on the patched kernel, and the captured
> >   /proc/asound state was byte identical. That covers the PCM stream
> >   names from fill_pcm_stream_name() live.
> > 
> >  sound/hda/codecs/generic.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/hda/codecs/generic.c b/sound/hda/codecs/generic.c
> > index 660a9f2c0ded..5f373cbf4a53 100644
> > --- a/sound/hda/codecs/generic.c
> > +++ b/sound/hda/codecs/generic.c
> > @@ -2712,10 +2712,12 @@ static void get_jack_mode_name(struct hda_codec *codec, hda_nid_t pin,
> >  			       char *name, size_t name_len)
> >  {
> >  	struct hda_gen_spec *spec = codec->spec;
> > +	size_t used;
> >  	int idx = 0;
> >  
> >  	snd_hda_get_pin_label(codec, pin, &spec->autocfg, name, name_len, &idx);
> > -	strlcat(name, " Jack Mode", name_len);
> > +	used = strnlen(name, name_len);
> > +	strscpy(name + used, " Jack Mode", name_len - used);
> >  
> >  	for (; find_kctl_name(codec, name, idx); idx++)
> >  		;
> > @@ -5682,6 +5684,7 @@ static const struct hda_pcm_stream dyn_adc_pcm_analog_capture = {
> >  static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
> >  				 const char *chip_name)
> >  {
> > +	size_t used;
> >  	char *p;
> >  
> >  	if (*str)
> > @@ -5695,7 +5698,8 @@ static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
> >  			break;
> >  		}
> >  	}
> > -	strlcat(str, sfx, len);
> > +	used = strnlen(str, len);
> > +	strscpy(str + used, sfx, len - used);
> >  }
> >  
> >  /* copy PCM stream info from @default_str, and override non-NULL entries
> 
> Hmm...  IMHO, those changes are *too ugly*.
> 
> Is the reason to drop strlcat() is only about the performance, no?
> If it were some security hardening, I'd find OK, but if not, this kind
> of change is doubtful: the code path is no hot path, hence the effect
> is nothing, and yet readability becomes significantly worse.
> 
> 
> thanks,
> 
> Takashi

I'm not a core contributor to the Linux hardening project, so I can't
speak on their behalf. However, my understanding is that strlcat()
removal is a hardening target and not purely motivated by
performance. strlcat() is prone to out of bounds reads and to out
of bounds writes when the supplied size does not match the buffer.
Even the fortified version can only catch those when the buffer
sizes are visible to the compiler. Its kernel-doc in
include/linux/fortify-string.h says "Do not use this function".

The readability point is fair. A v2 could keep every call site to
one line with a small local helper:

	hda_append_suffix(name, " Jack Mode", name_len);

A seq_buf conversion would also be possible.

Would either shape be acceptable, or would you rather this file be
left as is?

Thanks,
Ian
