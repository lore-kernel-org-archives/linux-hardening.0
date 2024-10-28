Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA318E05A;
	Mon, 28 Oct 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159139; cv=none; b=nfIW7l47yllkMBhmg0W+R5TdKB+3gWtH/QokpSBj6riVkAyFM0XevzL1rum3Vg4T/twZHzYjERxnOfdpLgTa5KLe03bQ+/pnpjZ1EadxrEJtVRP9RjtZtJm0nAwPoaxVeY4mHz1zgH7H9AcbBEF3vQcSuzkIquusNf9VCyYpDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159139; c=relaxed/simple;
	bh=PsTGH/9Ub2NfuqfUh00DfLpIpZXLRTLsrt/TPHNjJdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptip6qSpXOT/SqrLIStuxaYygR6PniBWEZOVOs3vsataj6j/tZuCKEn8moWrXFy0Ew3y/Gs58rS5CTTiRzLDQfn3Qy+FyM05pMukXCKhHp2cr0S1Gg1TN6dvAYz6nRsEhwDZhajXAVhxA+1b70F5QJZoOJpBSc2mj9NLL0JoYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMSjvrDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMSjvrDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E28C4CECD;
	Mon, 28 Oct 2024 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730159138;
	bh=PsTGH/9Ub2NfuqfUh00DfLpIpZXLRTLsrt/TPHNjJdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMSjvrDQqf8T8IWUvIpEw2rxnO16/3kVnAFkZ0JZaA4txTa77UPNs3DYhNvdZM8n8
	 7Dn/jWu02kvvnkGpjnkkCq9XXeTPP67UgUszBOcOqHDZ+LyyxeJ5AzJrHo+YiOnRqs
	 n3/nzQGXXHt0+JTpploDCwXOUy1E/5G1JAU+BVTWiLe2J6VzCoZ+unahl/bh0cFMrS
	 PmFIBmYCwDX3Hg9P4c88E28A9/JaXMo19dMuTHmH+LlcmIdS9EaTjgDrWUzpKEDx+B
	 4dqXXFXY6uNAMZE3yUqBHr1dZlErS7tHwe2srwW6SaYMF4jgkmVd0YVgjxJ2qqvBac
	 egHtnt488mh6w==
Date: Mon, 28 Oct 2024 16:45:35 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Aleksei Vetrov <vvvvvv@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Message-ID: <202410281645.5FFC8E6E@keescook>
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>

On Mon, Oct 28, 2024 at 04:58:58PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 28/10/24 16:50, Aleksei Vetrov wrote:
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
> 
> As in the previous patch, this should include the following tag
> (and probably CC stable):
> 
> Fixes: 80e698e2df5b ("ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by")

Whoops! My mistake. :) Thanks for catching this one!

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> 
> Thanks
> -- 
> Gustavo
> 
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
> > +	(*list)->num_widgets = size;
> > +
> >   	list_for_each_entry(w, widgets, work_list)
> >   		(*list)->widgets[i++] = w;
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241028-soc-dapm-bounds-checker-fix-5bae621455b2
> > 
> > Best regards,
> 
> 

-- 
Kees Cook
