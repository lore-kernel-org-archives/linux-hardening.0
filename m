Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032361EA91;
	Wed, 22 May 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366930; cv=none; b=Utd9u9halQpKX3cyLF0mtjeEOhXgDxvFQ7rfCvmCHM1Pu1+Nhwd9A3u+f1kYNLM/S12/3YzC67QWtfRTOTMSVM7oIXO+FC6Dr1X1ZR57m02/w+zFUEvLZ4WYU8CEp3b/Y/ihk3xyxixcnMHddKRDF4nyChy/ZymhqXZJrSbKtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366930; c=relaxed/simple;
	bh=QQNKugEsLR4Zxngf3KdWr5FWEuPBdF2sYz5hfdGxDQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cm+fAzVKZ0YBBLEJPJbu4aYb2+HDfTKbo7Tc3AIugUGvMAYqkWknA4tASRlAUsKYzaYQuETO+0nHJhOaKUAsWmz7PWek+feS1wTZbGJhrRA8bNoiLYQhCTMI48Na+eEPl56Bb2KyugrVfyxtzdADs9/MAOuKaLp5MF1mVTSjfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1XzmQrk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b8oaISQS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VS+FrNt5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v9Z4QZ8O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1XzmQrk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b8oaISQS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VS+FrNt5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v9Z4QZ8O"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E082F34C24;
	Wed, 22 May 2024 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716366926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWndrgG/Ib+G3BT3J07GW9jQZDryptwZKaxFblL8oDg=;
	b=f1XzmQrkEYZ0PEZ/bg7/qszRrTTm+hsEL0euZX7DQntBg0qNQXZtHGkStFQPa8JbwsC10A
	e8d8UUBVPg/zYyBtsyaqCase+h9J0Jgp1l3mL15ABLM56AW+oRzSAr6ocak6dCjC3LbVwI
	Bb0XHuYZNtpHylYAAxNqeVhPuTCnR1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716366926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWndrgG/Ib+G3BT3J07GW9jQZDryptwZKaxFblL8oDg=;
	b=b8oaISQSGgnLsRof6WTzL8CmgdM74YzZwXvFQ6pfv+nGPjVWI6zP79Ikr3KfpzGMo9FktN
	jdh0d8SZOCzLeACg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716366925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWndrgG/Ib+G3BT3J07GW9jQZDryptwZKaxFblL8oDg=;
	b=VS+FrNt5MsAFcaVeSBoZPJCOQRFha6G5oYXRUoDYswoQM+wnaPNiw808zAg/fdReA5Hgc+
	6DLP2ju+ONd0X059T7QvbVqgOgv3zDOErxZwmO0tIU85Ea369OsEwi8I7J3Tw2WnYqdri2
	PIwRomRbZ5E5RkyjjCKUoB3ixZkar1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716366925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWndrgG/Ib+G3BT3J07GW9jQZDryptwZKaxFblL8oDg=;
	b=v9Z4QZ8OVS2BUiEKq2BELvyygyttIWy/IWvBPk1OcGiP80MCMYEzS/4c64zHDWSt4fzXoq
	SEKMRWqHe2egp6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A8D113A1E;
	Wed, 22 May 2024 08:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fZ8xJE2uTWZEUQAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 22 May 2024 08:35:25 +0000
From: Nicolai Stange <nstange@suse.de>
To: Kees Cook <keescook@chromium.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,  Arnd Bergmann <arnd@arndb.de>,
  "Gustavo A. R. Silva" <gustavoars@kernel.org>,
  linux-hardening@vger.kernel.org,  Elena Reshetova
 <elena.reshetova@intel.com>,  Thomas Gleixner <tglx@linutronix.de>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] randomize_kstack: Improve entropy diffusion
In-Reply-To: <20240309202445.work.165-kees@kernel.org> (Kees Cook's message of
	"Sat, 9 Mar 2024 12:24:48 -0800")
References: <20240309202445.work.165-kees@kernel.org>
Date: Wed, 22 May 2024 10:35:20 +0200
Message-ID: <87seya452v.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Flag: NO
X-Spam-Score: -2.10
X-Spam-Level: 
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	INVALID_MSGID(1.70)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Kees Cook <keescook@chromium.org> writes:

>
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_k=
stack.h
> index 5d868505a94e..6d92b68efbf6 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>  	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
>  				&randomize_kstack_offset)) {		\
>  		u32 offset =3D raw_cpu_read(kstack_offset);		\
> -		offset ^=3D (rand);					\
> +		offset =3D ror32(offset, 5) ^ (rand);			\

Hi Kees,

I'm wondering whether this renders the per-arch mask applied to 'rand'
at the respective choose_random_kstack_offset() invocations ineffective?

Like e.g. on x86 there is

  choose_random_kstack_offset(rdtsc() & 0xFF);

I would argue that while before the patch kstack_offset had been
guaranteed to stay within the bounds of 0xFF, it's now effectively
unlimited (well, <=3D (u32)-1) and only capped to 0x3ff when subsequently
applying the KSTACK_OFFSET_MAX().

Or am I simply missing something?

Thanks!

Nicolai

>  		raw_cpu_write(kstack_offset, offset);			\
>  	}								\
>  } while (0)

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)
