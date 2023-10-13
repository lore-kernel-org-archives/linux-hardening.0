Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8542628E
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pk4BHYMD"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C520BE
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 14:23:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3296b49c546so2119948f8f.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232227; x=1697837027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfpxjmqKWAP/TvRZiRBZ/0u87oNwDFcwckD3AhjCRcw=;
        b=Pk4BHYMDZDrmOqTUFZANMSDx+Wk+XIrBSmUzOgo/yFPNLHYsOP6eZfwXPRk+94XKDT
         bF9v0q6qoU9DcvDEOWYmiZFKur7tdOD1GWm7UBkqwR6FEHzmtXfvLGS66Ze+7S3tOFE8
         55pKd8QvkvfE51gRO1RQFpUBgSZdZiYeI9+gKh7hRO6z0EMhfHicHS+oOdRp/XKjSjSj
         mjbGT/db0yqyxMEJaKMKByL07kWlVjCGWjh5w2lXWEw+v/6Grnlwvre/jT+8QoQ4Qm0R
         jCKxea7GBfoWsurw+J3WroR6OJhj2zm5scCboWENkHTWam/3mvx93gNMeDkPebnTfqGT
         9NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232227; x=1697837027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfpxjmqKWAP/TvRZiRBZ/0u87oNwDFcwckD3AhjCRcw=;
        b=scN+r3IeOg3adSToXz/plyEramB4zynd/7dz24fCB5N+uAFT0TmpB9D+omP7QhZGKy
         TM8AgEyhQnRG0wfW1NTJCYN9lYdyN2VtFsbAEWvUVmAQrN5I0D8kL1BfgOLorimlnh23
         ASM3Abdn4ak/xC3+XqoRsbP7IT64VxMr1qPxs9DudpjPLLPuTt47es5Tjd6ZW5VW/4UC
         GeABjxu9eTZwXuhT2TNphiyMCKqKe3OzCeYg3US5YL0o+6B+jccsyeTqtwK+fO/SXcMA
         DjSursWo6yPYWQLa2OFFZ0rtyrxkG0JKQRKkcqiLIIDPkLgIF9ItribplS1Gk94vWguj
         hGyA==
X-Gm-Message-State: AOJu0Yx7/b8UU0XB9bQfmDKEMmoKrLA7aQg/B8MGrwKPE74asuXEGYxy
	b8lXK2V0SNR4Pb+Ql3xTiSnUelKfUhu5U+qt/89TlQ==
X-Google-Smtp-Source: AGHT+IHxDwhVqInGk7BiQveJbA9TaPpEBc5Yl6GOHMegt7MA2b0u3Ng1Hx6YYVyD8vA74P7m1Y/WtXBTD1PXvcn1QAs=
X-Received: by 2002:adf:f84c:0:b0:32d:a045:4c88 with SMTP id
 d12-20020adff84c000000b0032da0454c88mr1767302wrq.12.1697232226669; Fri, 13
 Oct 2023 14:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch> <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch> <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
In-Reply-To: <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 13 Oct 2023 14:23:34 -0700
Message-ID: <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 2:12=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Fri, Oct 13, 2023 at 1:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Fri, Oct 13, 2023 at 12:53:53PM -0700, Justin Stitt wrote:
> > > On Fri, Oct 13, 2023 at 5:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> =
wrote:
> > > >
> > > > > -     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > > > > -             strncpy(data + i * ETH_GSTRING_LEN,
> > > > > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN=
);
> > > > > -     }
> > > > > +     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > > > > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].st=
ring);
> > > > >  }
> > > >
> > > > I assume you are using "%s" because tja11xx_hw_stats[i].string cann=
ot
> > > > be trusted as a format string? Is this indicating we need an
> > > > ethtool_puts() ?
> > >
> > > Indeed, it would trigger a -Wformat-security warning.
> > >
> > > An ethtool_puts() would be useful for this situation.
> >
> > Hi Justin
> >
> > hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, netvsc_stat=
s[i].name);
> > hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, vf_stats[i]=
.name);
> > ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40=
e_gstrings_priv_flags[i].flag_string);
> > ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40=
e_gl_gstrings_priv_flags[i].flag_string);
> > ethernet/intel/ice/ice_ethtool.c:                       ethtool_sprintf=
(&p, ice_gstrings_priv_flags[i].name);
> > ethernet/intel/igc/igc_ethtool.c:                       ethtool_sprintf=
(&p, igc_gstrings_stats[i].stat_string);
> > ethernet/intel/ixgbe/ixgbe_ethtool.c:                   ethtool_sprintf=
(&p, ixgbe_gstrings_test[i]);
> > ethernet/netronome/nfp/nfp_net_ethtool.c:                       ethtool=
_sprintf(&data, nfp_self_test[i].name);
> > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf=
(&data, nfp_net_et_stats[i + swap_off].name);
> > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf=
(&data, nfp_net_et_stats[i - swap_off].name);
> > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf=
(&data, nfp_net_et_stats[i].name);
> > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool=
_sprintf(&p, txq_stat_names[j]);
> > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool=
_sprintf(&p, xdpq_stat_names[j]);
> > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool=
_sprintf(&p, rxq_stat_names[j]);
> > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool=
_sprintf(&p, tls_stat_names[j]);
> > ethernet/amazon/ena/ena_ethtool.c:              ethtool_sprintf(&data, =
ena_stats->name);
> > ethernet/amazon/ena/ena_ethtool.c:                      ethtool_sprintf=
(&data, ena_stats->name);
> > ethernet/brocade/bna/bnad_ethtool.c:            ethtool_sprintf(&string=
, bnad_net_stats_strings[i]);
> > ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, io=
nic_lif_stats_desc[i].name);
> > ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, io=
nic_port_stats_desc[i].name);
> > ethernet/hisilicon/hns/hns_dsaf_gmac.c:         ethtool_sprintf(&buff, =
g_gmac_stats_string[i].desc);
> > ethernet/hisilicon/hns/hns_dsaf_xgmac.c:                ethtool_sprintf=
(&buff, g_xgmac_stats_string[i].desc);
> > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, v=
mxnet3_tq_dev_stats[i].desc);
> > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, v=
mxnet3_tq_driver_stats[i].desc);
> > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, v=
mxnet3_rq_dev_stats[i].desc);
> > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, v=
mxnet3_rq_driver_stats[i].desc);
> > vmxnet3/vmxnet3_ethtool.c:              ethtool_sprintf(&buf, vmxnet3_g=
lobal_stats[i].desc);
> >
>
> Woah, are these all triggering -Wformat-security warnings?

Erhm, I guess -Wformat-security is turned off:

./scripts/Makefile.extrawarn +16:
KBUILD_CFLAGS +=3D -Wno-format-security

Kees, what do you think about this warning and the semantics of:

1) ethtool_sprintf(&data, "%s", some[i].string);
2) ethtool_sprintf(&data, some[i].string);
3) ethtool_puts(&data, some[i].string);

>
> > It looks like there are enough potential users to justify adding
> > it. Do you have the time and patience?
>
> I do :)
>
> Should I create ethtool_puts() and then submit adoption patches
> for it in the same series? Or wait to hear back about how ethtool_puts()
> is received.
>
> >
> >     Andrew
>
> Thanks
> Justin
