Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421D433AD
	for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167957; cv=none; b=Ne/CSFMckieAmGu5RizjU+PfNf3MjL4VUsXJkrTKqihMIKlTm9EkXzWdApuSeEYFvVJJtOts6dBqaTSR0hDvNhWl6tRhZSP8or1DMozF+0rFbqbJq8C8TEpCLoKeNW1lkJS+OV3FeYr/9yF2oSxLdb75joq+qaNv3UisN3beRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167957; c=relaxed/simple;
	bh=cvt2KaSAbICkzR8yA8oqgyghUNUOih7dozk9zGui538=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH5L7qV6q2+qZ9B1A/B+nCmuPYb0p7z1apvGHO4IMxiWasJlvZ0DCAnYSTh0EqCHOXO3D/K0pruh0EtdC3gEheQ25OtkGd2G+klVYHFIjG5iIFhA/PrzY4Ak3ELkI7gdOPsA3ekj3rKQOpOvQkArNHXPGI1CotKDth+1xzz3uDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPJ87RdG; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPJ87RdG"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-635355713d9so3983042d50.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759167955; x=1759772755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rr8asw5w2LFtUosgimvTpY49NuIARrcjW6GWqnOLnQ=;
        b=fPJ87RdGWQT/+llTnIxJH35xU1iG50shaaZBq6giGWUhC9iNElcAt64SuudOtRPzdQ
         7ct/HW51p+AXQ78rBY6uDS8t6rE5v1IbH1e6kpxCl9tyuzCDyc6wYtOdUe9OZl2YfRYZ
         vVZlP1yJPv3SZL3drYttw+pZI3PrIXWmcJC3jLKSAPNxK5V9LVwwZq+DdSGi19Ly2cZi
         nJ2MfTJhqbP7Y0aQ/8Vnd1YPXhybn+TY1yC726rNMVKZcj+H3RrtLe+yvx9M0kLNcJW/
         wWpjKJRlwEPw0IW7B7njMGvBBQsFP+3ZL6vGfJSS7F1w7Ta7GIPz4cCN0qUcqjSEzFii
         rD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167955; x=1759772755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rr8asw5w2LFtUosgimvTpY49NuIARrcjW6GWqnOLnQ=;
        b=tFLOEfVPhvhXBPSW4kTwSndPPjuIcYlnkryJvV3w498kySypVyJljYjZ5VbCwq48eM
         +iSbVSJ9PCldbxawKb8IeVRZvg94eriWO7Kex9NHVWjpSBh1YXZH1OJxcAPJ4cCZhTFz
         y/yASnR/W9B5cb4Ay4Tbk2D2j+IIhvlb/lc8Qdr6onV3sbA3IWikXilaIqZWtITe9ViD
         3Gvb3HT+YuRUR7tdZTY31/VlmKsKjg9Di203EfBG0aJA1nyXy5C899uAe78b9Q/bH64Q
         kXlmv+nxtepI7jsAdcfAidyELd65TlG9UKonN0eezSINvr2GIBfvp6R1qJcgUNe8R+IR
         M1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUrrZxvEEffmOs/VbngtnJaF9ImDS7gjrH6sO7yd0QgaJMjcEUM0Qehvwb2PR3ds5+M++GfuE3h+pZQrjSSkSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybg0bhW+U4CmPseD/nJYAoHNscRILQ704g5rugfu0jcEUXI4Bp
	u61PDxCMSGr4dFP56qgYff3HwJb2eBwjglrLKvWBUk3P7xXm8FNhzvFQnQX4bTBDukJEYL9UYlj
	6CikPInjjkpoC2jyI/iqrPBf1tEA0jus=
X-Gm-Gg: ASbGnctbttJ5GIjtihWhSt5h4xbYAFgpIYxInfz2o89lqdngIJC6DG9On5nr/yfgtOv
	jhgT0+O07CP+3/j63KAJ6oMnj88VSl3EU4BJrztRJgIrwNl5zrWKcNEoX7iZBr6qf5eUM0ny6W/
	rbMNgs3lMrnzU42FewBS/co6AmZCpl4xftfxjtSVhqlgBGCrNfVHo1DxtKIXJLaXAQ8KVeanml9
	Rp+Ob5qUlXxPUSl5z8=
X-Google-Smtp-Source: AGHT+IGWN1U3ruetQeiQiZtCe48SxGVf5HYlg+D8N8D2z6yt7sbK2mz/SAzZzQHv+qRuaJ8dGFMSUcAUInTb49quAHc=
X-Received: by 2002:a05:690e:2508:b0:635:4ecd:75a4 with SMTP id
 956f58d0204a3-6361a8ad38amr14381272d50.50.1759167954977; Mon, 29 Sep 2025
 10:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926000200.837025-1-jmeneghi@redhat.com> <20250926000200.837025-8-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-8-jmeneghi@redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 29 Sep 2025 10:45:40 -0700
X-Gm-Features: AS18NWDiG_e____J7dH1E1fhXzMsXsdLMiodTDWlX59WmDK7fVQpz_X3soSeuJk
Message-ID: <CABPRKS9SkaGZjC_vEy-YdgYELffGLvub7DTFGCYXFW68ObWqYg@mail.gmail.com>
Subject: Re: [PATCH v10 07/11] scsi: scsi_transport_fc: add fc_host_fpin_set_nvme_rport_marginal()
To: John Meneghini <jmeneghi@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, 
	hch@lst.de, Justin Tee <justin.tee@broadcom.com>, james.smart@broadcom.com, 
	kees@kernel.org, linux-hardening@vger.kernel.org, njavali@marvell.com, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

> +       u64 local_wwpn =3D fc_host_port_name(shost);
If CONFIG_NVME_FC is not enabled, then the u64 local_wwpn variables
aren=E2=80=99t used anywhere.

drivers/scsi/scsi_transport_fc.c: In function
=E2=80=98fc_host_fpin_set_nvme_rport_marginal=E2=80=99:
drivers/scsi/scsi_transport_fc.c:900:13: warning: unused variable
=E2=80=98local_wwpn=E2=80=99 [-Wunused-variable]
  900 |         u64 local_wwpn =3D fc_host_port_name(shost);
      |             ^~~~~~~~~~
drivers/scsi/scsi_transport_fc.c: In function =E2=80=98fc_rport_set_margina=
l_state=E2=80=99:
drivers/scsi/scsi_transport_fc.c:1309:13: warning: unused variable
=E2=80=98local_wwpn=E2=80=99 [-Wunused-variable]
 1309 |         u64 local_wwpn =3D fc_host_port_name(shost);
      |             ^~~~~~~~~~

Perhaps we need to ifdef the u64 local_wwpn declarations in both
fc_host_fpin_set_nvme_rport_marginal and fc_rport_set_marginal_state
routines too?

#if (IS_ENABLED(CONFIG_NVME_FC))
u64 local_wwpn =3D fc_host_port_name(shost);
#endif

Regards,
Justin
