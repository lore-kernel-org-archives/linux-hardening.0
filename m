Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C0241E5
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBaaSXK1"
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16EBF
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 14:12:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso4377199a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697231567; x=1697836367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Li0CJUc3AAYY2ID9vtBx9Y6C6M7aGLDvXjXcw/aCw=;
        b=mBaaSXK1I5ptvwYwXEbZNty4oAekgLoL8fTQMnd8WgD9uIHa6pKiDxNvTYefxPsm6W
         V1ooqH5HWVIJ1yvOxIpv3FMwCnk/a70obO163LpHKrEe75h2HEF/oLE90E5rgJxphSSD
         v1XQiS4wNcFYg1Dr0kPfjLpKo/RG7qOwBSsyjuxchyaXf/Yln5tWyiVUIpEUoOm9VvN6
         7GLeIMEYEynxwDyR4QG220lf+5SmS2W3nblWhHGtMJ5+3NVx1TX47ZlJxb4sIORfh3MP
         rmdNb7tufK6h/8pOz3FCP7oUkpmrnqhGsNYVjKZMIB8p7NKqdVkRW0MeL8EHcH1Ud65Z
         QAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231567; x=1697836367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65Li0CJUc3AAYY2ID9vtBx9Y6C6M7aGLDvXjXcw/aCw=;
        b=d+s2l2sm2KO7P+SXVio3mpKqdOMkYII2/n6bqlK1smbMAgr97frZxNsnR3qF/FN13a
         znIpDN2Xt2C1q6AKCVuOrFvYDDqTLEesC057+DfUcd2e0HpAw18G2jw5RMBiU3fupUW6
         Eyu/JKXLFTV4N4GuiyK8SGAingm1jC7RPuZU6Da2L1Bsv0YM5g2SJ7iXD00CQYpGLz9e
         jM3XjXHPoE39Bg6b7ikKywbgS1OlxAeKUwy6C9ZEWseCiWDlY9h4uFHMZHJ/3MM9ugW2
         qFAjInKJ0dvQ8CzUpcA1N2EIxK2Pk+fVQtYCY40XJ3jkGhdD7buXgDWxPSueYvztdV/G
         477Q==
X-Gm-Message-State: AOJu0Yx4qNmylDKqTX4sc4ElG0X8vxklSXzrPcjRJ5I9uluakVLk6gjD
	etLyvE8MdgUiGwykIZjMqtDHvape6UX2NtSyINX65w==
X-Google-Smtp-Source: AGHT+IECae+iT+rBLZo5NuHqthDxyRPk1+BH5q2rVfgRV9e5y2Dk1JwjKBHx5Cq7DDrLHjTGu8UXwVnF8HWTbbm75no=
X-Received: by 2002:a05:6402:2707:b0:53e:1434:25db with SMTP id
 y7-20020a056402270700b0053e143425dbmr5372450edd.23.1697231567170; Fri, 13 Oct
 2023 14:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch> <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
In-Reply-To: <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 13 Oct 2023 14:12:34 -0700
Message-ID: <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 1:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 13, 2023 at 12:53:53PM -0700, Justin Stitt wrote:
> > On Fri, Oct 13, 2023 at 5:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > -     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > > > -             strncpy(data + i * ETH_GSTRING_LEN,
> > > > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > > > -     }
> > > > +     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > > > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].stri=
ng);
> > > >  }
> > >
> > > I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> > > be trusted as a format string? Is this indicating we need an
> > > ethtool_puts() ?
> >
> > Indeed, it would trigger a -Wformat-security warning.
> >
> > An ethtool_puts() would be useful for this situation.
>
> Hi Justin
>
> hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, netvsc_stats[=
i].name);
> hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, vf_stats[i].n=
ame);
> ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_=
gstrings_priv_flags[i].flag_string);
> ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_=
gl_gstrings_priv_flags[i].flag_string);
> ethernet/intel/ice/ice_ethtool.c:                       ethtool_sprintf(&=
p, ice_gstrings_priv_flags[i].name);
> ethernet/intel/igc/igc_ethtool.c:                       ethtool_sprintf(&=
p, igc_gstrings_stats[i].stat_string);
> ethernet/intel/ixgbe/ixgbe_ethtool.c:                   ethtool_sprintf(&=
p, ixgbe_gstrings_test[i]);
> ethernet/netronome/nfp/nfp_net_ethtool.c:                       ethtool_s=
printf(&data, nfp_self_test[i].name);
> ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&=
data, nfp_net_et_stats[i + swap_off].name);
> ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&=
data, nfp_net_et_stats[i - swap_off].name);
> ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&=
data, nfp_net_et_stats[i].name);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, txq_stat_names[j]);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, xdpq_stat_names[j]);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, rxq_stat_names[j]);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, tls_stat_names[j]);
> ethernet/amazon/ena/ena_ethtool.c:              ethtool_sprintf(&data, en=
a_stats->name);
> ethernet/amazon/ena/ena_ethtool.c:                      ethtool_sprintf(&=
data, ena_stats->name);
> ethernet/brocade/bna/bnad_ethtool.c:            ethtool_sprintf(&string, =
bnad_net_stats_strings[i]);
> ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ioni=
c_lif_stats_desc[i].name);
> ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ioni=
c_port_stats_desc[i].name);
> ethernet/hisilicon/hns/hns_dsaf_gmac.c:         ethtool_sprintf(&buff, g_=
gmac_stats_string[i].desc);
> ethernet/hisilicon/hns/hns_dsaf_xgmac.c:                ethtool_sprintf(&=
buff, g_xgmac_stats_string[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_tq_dev_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_tq_driver_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_rq_dev_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_rq_driver_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:              ethtool_sprintf(&buf, vmxnet3_glo=
bal_stats[i].desc);
>

Woah, are these all triggering -Wformat-security warnings?

> It looks like there are enough potential users to justify adding
> it. Do you have the time and patience?

I do :)

Should I create ethtool_puts() and then submit adoption patches
for it in the same series? Or wait to hear back about how ethtool_puts()
is received.

>
>     Andrew

Thanks
Justin
