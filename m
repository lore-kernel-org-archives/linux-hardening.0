Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E098BEA;
	Tue, 29 Oct 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204458; cv=none; b=mwFOuy3cF2Q9IP9a7pkchAIf5pq1bdfT4KS3YpejLOYPQYeSL2hkv7OBXGmboTyBdSjvoTwEb2dRQmg1YEjDClGliWc0SFSJzshQoZb6DoGxe5lLIJxqO8XcivV9CVWy5jEVzd2iLn0OepQLkqTzO5v8MuoYqwHfPIu1cNN4oXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204458; c=relaxed/simple;
	bh=XzRuZ2uerAbiK0qOnJNMd09rewLjEyvoVVHdzfcH5pM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK1BwgkAk3FlKe76Fls3PTzDJz6Cj0uDyHSFH1ipHuE8D6UWwH38XR0AQbJELmDnOpy0m7dKXN/BD2fEJLIGwq0kzKTIcvfE4xrz3zvoSz9XiwY5UxzT8orv8L2zCa5u0VaDaJ4D+rH94+ue73+YsswwQtrTfVNcqp6z2kYPzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SXqv0Lfd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pF1MQb9O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V4Irx20k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K1H8dXrc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SXqv0Lfd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pF1MQb9O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V4Irx20k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K1H8dXrc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74A031FE6C;
	Tue, 29 Oct 2024 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730204452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0zS0G0SfdkDSLnWBot6CN8J06azX78iYIDCYB7tZp0=;
	b=SXqv0Lfd7abbyyzOo+uJzncTDWk43cw0vqX76djqwxZ2iQNNhtD0QcUZfXxJHb8+PjwCkZ
	vyIREXjTbAwFeo0HeB4TXAW5iLIHyNcvI3SpKztAUq0m3ikqhXaHIjJvXH692fX0/KHtWj
	CvMyBRZAMIeIfpDZJHZcXKXd7wBkoQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730204452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0zS0G0SfdkDSLnWBot6CN8J06azX78iYIDCYB7tZp0=;
	b=pF1MQb9ONSqNS2AOKlCP4d9OYr2vEjR3XeTwr2SuNYLAfs49l/EsFnSoNghrslSu/lIUWd
	dfY/R1X1ZoRD/zDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730204451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0zS0G0SfdkDSLnWBot6CN8J06azX78iYIDCYB7tZp0=;
	b=V4Irx20kzNkuKs+0WmtlhHVymQ7zZ7QZyjdpC1XpqYs2ZBSY1REKfShx3XM7z1rSczhP+Q
	SBydev4EHEFX/I7xS7/iGFEn9jGZXUwKi4dKHCPyzAKtPefZdf8Gtnz0ESFw4uOj3ej9yK
	B59BiIgHpatJnQJ4faBJyaY5NLNp9pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730204451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0zS0G0SfdkDSLnWBot6CN8J06azX78iYIDCYB7tZp0=;
	b=K1H8dXrctX0rcEUM0XawGYwbFSY1IliC6U5P082XzqumIIz2KXe923j/E+XODLOLnu33xQ
	pgX0Zc0tBygv7sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5193A136A5;
	Tue, 29 Oct 2024 12:20:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yX5nEyPTIGcdVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Oct 2024 12:20:51 +0000
Date: Tue, 29 Oct 2024 13:21:39 +0100
Message-ID: <87h68v14mk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Aleksei Vetrov <vvvvvv@google.com>,
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
In-Reply-To: <c9002b28-77a9-4be0-94a6-bf700e0abaab@linux.intel.com>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
	<987b8806-2ec7-41f7-bdeb-8f843c34a993@linux.intel.com>
	<87plnj19ry.wl-tiwai@suse.de>
	<c9002b28-77a9-4be0-94a6-bf700e0abaab@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,google.com,gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 29 Oct 2024 13:11:32 +0100,
Amadeusz S³awiñski wrote:
> 
> On 10/29/2024 11:30 AM, Takashi Iwai wrote:
> > On Tue, 29 Oct 2024 10:50:21 +0100,
> > Amadeusz S³awiñski wrote:
> >> 
> >> On 10/28/2024 11:50 PM, Aleksei Vetrov wrote:
> >>> The widgets array in the snd_soc_dapm_widget_list has a __counted_by
> >>> attribute attached to it, which points to the num_widgets variable. This
> >>> attribute is used in bounds checking, and if it is not set before the
> >>> array is filled, then the bounds sanitizer will issue a warning or a
> >>> kernel panic if CONFIG_UBSAN_TRAP is set.
> >>> 
> >>> This patch sets the size of the widgets list calculated with
> >>> list_for_each as the initial value for num_widgets as it is used for
> >>> allocating memory for the array. It is updated with the actual number of
> >>> added elements after the array is filled.
> >>> 
> >>> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> >>> ---
> >>>    sound/soc/soc-dapm.c | 2 ++
> >>>    1 file changed, 2 insertions(+)
> >>> 
> >>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> >>> index c34934c31ffec3970b34b24dcaa0826dfb7d8e86..99521c784a9b16a232a558029a2f3e88bd8ebfb1 100644
> >>> --- a/sound/soc/soc-dapm.c
> >>> +++ b/sound/soc/soc-dapm.c
> >>> @@ -1147,6 +1147,8 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
> >>>    	if (*list == NULL)
> >>>    		return -ENOMEM;
> >>>    +	(*list)->num_widgets = size;
> >>> +
> >>>    	list_for_each_entry(w, widgets, work_list)
> >>>    		(*list)->widgets[i++] = w;
> >>>    
> >> 
> >> and after that there is (*list)->num_widgets = i;
> >> 
> >> Can this be somehow simplified to remove 'i', if it set before assignment?
> > 
> > That line can be removed after this change, I suppose.
> > The size is calculated from the list at the beginning, and it must be
> > the exact size.
> > 
> 
> Actually looking at this again, first iteration iterates through all
> widgets, while second one, only through work_list, which looks to me
> like it allocates more memory than needed in most cases.

Oh, you're right.  I don't know why two different loops are used,
though...


Takashi
