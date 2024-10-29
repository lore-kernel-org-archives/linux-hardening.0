Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB121839E4;
	Tue, 29 Oct 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197781; cv=none; b=UOJx2iVWQDSt55vpQccSNeOCY7yd8+ciKuE3CiG4bgnjif5BRnp2RhPa3Ud7I1woKJZ4NwzgHQ9roexrAOYdbG5MNSJ/01tS3QCySYRraks6A7oBp/OCDhHTbhnf/EL+PTC6wLhiWgXcBcz8m/NPqDQKOqJmVBqcxuFJv5vgvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197781; c=relaxed/simple;
	bh=RWDTkc2mC5P9oWE8l7uS05yQr/bSQVafDmQClHceYUE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHO++xeouhEvPn0mfNmwepUzmVO/vvXWh45TtYmIEGEgyFzkTUWLhC6E1MEjCXiUadRIQGy23HnM0QQlg4m5Y8JTHxxUu/ke44OfaQE0wWBh2YupHdM1R+PVcuMTHd1rk/p/QJsfvAoIz11vI8NfDSwkXy1o9wnYV13EhYdhDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SDRXj+3D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zo9sl49Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BHOU5eOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A0q0vgG3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SDRXj+3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zo9sl49Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BHOU5eOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A0q0vgG3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D97821F393;
	Tue, 29 Oct 2024 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730197778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0/vMU3FNM+TQ2c3PTiDPuUXc7T52Hqxj70/05xfkGk=;
	b=SDRXj+3DCKpfnTglx0e6CGtJiuowuPG9k4IGYXzU3gE2jeS6ULv58wmC3yE9UGdqs6IWqe
	2OubK89j6vWDRP1fzgeqRUf5A+rZQDf4oppjBahPdK2TuBHtvGPTmfdHOHCaHwxZzA2DjH
	fDZ3gIMwl99epZ85jkQAw4IkfRjFCEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730197778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0/vMU3FNM+TQ2c3PTiDPuUXc7T52Hqxj70/05xfkGk=;
	b=zo9sl49ZlLvaQjowd/bE0EI1jfjJvgrffMpiIGI3gYNBQPc8A2vx34qcvmzL1zv9tUn1XW
	e6ussS9lM8GjD/AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BHOU5eOh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A0q0vgG3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730197777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0/vMU3FNM+TQ2c3PTiDPuUXc7T52Hqxj70/05xfkGk=;
	b=BHOU5eOhjSAIMQBwT9Bfn+JFdGk/Tf4LNJTTeQsoWV4RBVOyZQWjsJhypoZmWYqfMxVnB+
	rcxhuB4b433clqcJCkeLB+XPTStQP8YiuvRtiKuXrO1fpG/Y7i/OmRa6Ib72HJzNM/dxej
	dpWkrQJUe+Ovab0rWRSNLAT0gx38ICE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730197777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0/vMU3FNM+TQ2c3PTiDPuUXc7T52Hqxj70/05xfkGk=;
	b=A0q0vgG32RIRG5TpXuO/0hPnD1bAqZJY/DnQ+okL8dT+x7YUeeVCJD11iXG3+FmLSAGJ+P
	7C7kPEBo/8T339Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5569139A2;
	Tue, 29 Oct 2024 10:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MaOaKxG5IGeQMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Oct 2024 10:29:37 +0000
Date: Tue, 29 Oct 2024 11:30:25 +0100
Message-ID: <87plnj19ry.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Aleksei Vetrov <vvvvvv@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in dapm_widget_list_create
In-Reply-To: <987b8806-2ec7-41f7-bdeb-8f843c34a993@linux.intel.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
	<987b8806-2ec7-41f7-bdeb-8f843c34a993@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D97821F393
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 29 Oct 2024 10:50:21 +0100,
Amadeusz S³awiñski wrote:
> 
> On 10/28/2024 11:50 PM, Aleksei Vetrov wrote:
> > The widgets array in the snd_soc_dapm_widget_list has a __counted_by
> > attribute attached to it, which points to the num_widgets variable. This
> > attribute is used in bounds checking, and if it is not set before the
> > array is filled, then the bounds sanitizer will issue a warning or a
> > kernel panic if CONFIG_UBSAN_TRAP is set.
> > 
> > This patch sets the size of the widgets list calculated with
> > list_for_each as the initial value for num_widgets as it is used for
> > allocating memory for the array. It is updated with the actual number of
> > added elements after the array is filled.
> > 
> > Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> > ---
> >   sound/soc/soc-dapm.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> > index c34934c31ffec3970b34b24dcaa0826dfb7d8e86..99521c784a9b16a232a558029a2f3e88bd8ebfb1 100644
> > --- a/sound/soc/soc-dapm.c
> > +++ b/sound/soc/soc-dapm.c
> > @@ -1147,6 +1147,8 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
> >   	if (*list == NULL)
> >   		return -ENOMEM;
> >   +	(*list)->num_widgets = size;
> > +
> >   	list_for_each_entry(w, widgets, work_list)
> >   		(*list)->widgets[i++] = w;
> >   
> 
> and after that there is (*list)->num_widgets = i;
> 
> Can this be somehow simplified to remove 'i', if it set before assignment?

That line can be removed after this change, I suppose.
The size is calculated from the list at the beginning, and it must be
the exact size.


thanks,

Takashi
